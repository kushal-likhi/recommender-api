package com.recommender.domain

import org.bson.types.ObjectId

class Role {

    ObjectId id
    String authority

    static constraints = {
        authority(blank: false, nullable: false)
    }
}
