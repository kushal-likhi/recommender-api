package com.recommender.domain

import org.bson.types.ObjectId
import com.recommender.enums.AlgorithmType

class Application {

    ObjectId id
    String secretKey
    AlgorithmType algorithm

    static hasMany = [failedEntries: FailedData]

    static belongsTo = [user: User]

    static constraints = {
    }
}
