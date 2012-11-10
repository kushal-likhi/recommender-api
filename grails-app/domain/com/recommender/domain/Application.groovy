package com.recommender.domain

import com.recommender.enums.AlgorithmType
import org.bson.types.ObjectId

class Application {

    ObjectId id
    String secretKey
    AlgorithmType algorithm
    String name
    Date dateCreated
    Date lastUpdated

    static hasMany = [failedEntries: FailedData]

    static belongsTo = [user: User]

    static constraints = {
        name(unique: 'user')
    }

    static mapping = {
        secretKey(type: 'text')
        failedEntries(cascade: 'all-delete-orphan')
    }
}
