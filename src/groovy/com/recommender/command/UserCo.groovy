package com.recommender.command

import com.recommender.domain.User


@grails.validation.Validateable
class UserCo {
    String email
    String password
    String firstName
    String lastName

    User getUser() {
        new User(email: email, password: password, firstName: firstName, lastName: lastName, enabled: true)
    }
}
