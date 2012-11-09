package com.recommender.domain

import org.bson.types.ObjectId

class User {

    ObjectId id
    String email
    String password
    String firstName
    String lastName

    Boolean enabled

    static hasMany = [applications: Application]

    static constraints = {
    }
}
