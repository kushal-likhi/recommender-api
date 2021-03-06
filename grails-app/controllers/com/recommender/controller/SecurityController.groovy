package com.recommender.controller

import com.recommender.domain.User
import com.recommender.security.StatelessSecurity
import cr.co.arquetipos.crypto.Blowfish
import org.bson.types.ObjectId

class SecurityController {

    def ourMailService
    def userService

    def logout() {
        use(StatelessSecurity) {request.destroyUserSession(response)}
        redirect(uri: '/')
    }

    def authenticate(String username, String password, Boolean remember) {
        User user = User.findByEmailAndPassword(username, password.encodeAsSHA256())
        if (user) {
            use(StatelessSecurity) {request.createSessionForUser(response, user.id.toString())}
            if (remember != null) use(StatelessSecurity) {request.createRememberMeCookie(response, user.id.toString())}
        } else {
            flash.userInvalid = "Credentials Did Not Match"
        }
        redirect(uri: '/')
    }

    def createUser(String firstName, String lastName, String email) {
        flash.userCreateErrorMessage = null
        if (User.collection.findOne(email: email)) flash.userCreateErrorMessage = "Email Already Taken"
        if (!flash.userCreateErrorMessage && new User(
                email: email,
                firstName: firstName,
                lastName: lastName,
                password: "Pending"
        ).save()) {
            ourMailService.sendMail(email, "Account Activation Link", "authLink", [
                    name: "${firstName} ${lastName}",
                    link: "${createLink(controller: 'security', action: 'activate', params: [token: email.encodeAsBase64(), auth: Blowfish.encryptBase64(email, email.encodeAsSHA256())], absolute: true)}"
            ])
            flash.userCreateMessage = g.render(template: '/security/createdAccount')
        } else {
            flash.userCreateMessage = "Unable to create your account. Please try again later."
        }
        redirect(uri: '/')
    }

    def activate(String token, String auth) {
        String email = Blowfish.decryptBase64(auth, new String(token.decodeBase64()).encodeAsSHA256())
        if (email.equals(new String(token.decodeBase64()))) {
            User user = User.collection.findOne(email: email) as User
            if (user && !user.enabled) {
                return [id: user.id, token: Blowfish.encryptBase64((new Date().getTime() + (10 * 60 * 1000)).toString(), user.id.toString())]
            }
        }
        redirect(uri: '/')
    }

    def activationComplete(String password, String userId, String token) {
        try {
            Long time = (Blowfish.decryptBase64(token, userId)).toLong()
            if (time < new Date().getTime()) throw new Exception("Token expired")
            User user = User.get(new ObjectId(userId))
            user.enabled = true
            user.password = password.encodeAsSHA256()
            user.save(flush: true)
            use(StatelessSecurity) {request.createSessionForUser(response, user.id.toString())}
            redirect(controller: 'user', action: 'dashBoard')
        } catch (exception) {
            log.error(exception.message)
            redirect(uri: '')
        }
    }

    def mainPageRelay() {
        if (request.loggedInUser) redirect(uri: '/dashboard')
        render(view: "/index")
    }

    def forgotPassword = {
        try {
            flash.forgotPasswordMsg = userService.mailPassword(params.email)
        } catch (Exception ex) {
            log.error("UserController forgotPassword : " + ex)
            flash.forgotPasswordMsg = " Sorry! Please try again"
        }
        redirect(uri: '/')
    }

}
