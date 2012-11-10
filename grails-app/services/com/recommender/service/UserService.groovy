package com.recommender.service

import com.recommender.command.UserCo
import com.recommender.domain.User
import org.apache.commons.lang.RandomStringUtils

class UserService {

    def ourMailService

    Map createUser(UserCo userCo) {
        Map result = [message: 'Please enter valid data']
        if (userCo.validate()) {
            if (User.countByEmail(userCo.email)) {
                result.message = 'User already exist'
                return
            }
            User user = userCo.user
            user.save(flush: true, failOnError: true)
            result.user = user
            result.message = "User has been created successfully"
        }
        return result
    }

    String mailPassword(String email) {
        String message = "User with given email id doesn't exist"
        if (email) {
            User user = User.findByEmailAndEnabled(email, true)
            if (user) {
                String password = RandomStringUtils.randomNumeric(5)
                user.password = password.encodeAsSHA256()
                user.save(flush: true, failOnError: true)
                ourMailService.sendMail(user.email, "Password Recovery", 'forgotPassword', [name: user.name, userName: user.email, newPassword: password])
                message = "Password has been emailed on your email id"
            }
        }
        return message
    }

}
