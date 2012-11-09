package com.recommender.service

import com.recommender.command.UserCo
import com.recommender.domain.User
import org.apache.commons.lang.RandomStringUtils

class UserService {

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
                user.password = RandomStringUtils.random(8)
                user.save(flush: true, failOnError: true)
                //email
                message = "Password has been emailed on your email id"
            }
        }
        return message
    }

}
