package com.recommender.domain

import org.bson.types.ObjectId

class User {

    ObjectId id
    String email
    String password
    String firstName
    String lastName

    Boolean enabled = false
    Boolean isAdmin = false

    Date dateCreated
    Date lastUpdated

    static hasMany = [applications: Application]
    static transients = ['name']
    static constraints = {
        email(email: true, blank: false)
    }

    static mapping = {
        applications(cascade: 'all-delete-orphan')
    }

    String getName() {
        return "${firstName} ${lastName ?: ''}"
    }

}
