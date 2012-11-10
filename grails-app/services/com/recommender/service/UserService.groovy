package com.recommender.service

import com.recommender.command.UserCo
import com.recommender.domain.User

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
}
