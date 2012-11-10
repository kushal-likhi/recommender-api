package com.recommender.domain

import org.bson.types.ObjectId

class User {

    ObjectId id
    String email
    String password
    String firstName
    String lastName

    Boolean enabled
    Date dateCreated
    Date lastUpdated

    static hasMany = [applications: Application]
    static transients = ['authorities', 'name']
    static constraints = {
        email(email: true, blank: false)
    }

    static mapping = {
        applications(cascade: 'all-delete-orphan')
    }

    transient boolean isAdmin() {
        authorities.contains("ROLE_ADMIN")
    }

    List getAuthorities() {
        List roles = []
        if (this.id) {
            roles = UserRole.findAllByUser(this)*.role*.authority
        }
        return roles
    }

    String getName() {
        return "${firstName} ${lastName ?: ''}"
    }

}
