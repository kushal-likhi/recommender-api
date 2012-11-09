package com.recommender.domain

import org.bson.types.ObjectId

class UserRole {

    ObjectId id
    Role role
    User user

    static constraints = {
        role(nullable: false)
        user(nullable: false)
    }
}
