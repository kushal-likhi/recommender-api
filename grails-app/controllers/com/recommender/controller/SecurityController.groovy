package com.recommender.controller

import com.recommender.security.StatelessSecurity
import com.recommender.domain.User
import cr.co.arquetipos.crypto.Blowfish


class SecurityController {

    def ourMailService

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
            ourMailService.sendMail(firstName, "Account Activation Link", "authLink", [
                    name: "${firstName} ${lastName}",
                    link: "${createLink(controller: 'security', action: 'activate', params: [token: email.encodeAsBase64(), auth: Blowfish.encryptBase64(email, email.encodeAsSHA256())])}"
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
            User user = User.collection.findOne(email: email)
            if (user && !user.enabled) {
                return [id: user.id]
            }
        }
        redirect(uri: '/')
    }

    def mainPageRelay() {
        println "here"
        println request.currentUser
        if (request.currentUser) redirect(uri: '/dashboard')
        render(view: "/index")
    }

}
