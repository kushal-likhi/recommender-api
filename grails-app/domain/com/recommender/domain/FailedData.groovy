package com.recommender.domain

class FailedData {

    String eventSource
    String eventTarget
    Integer weight

    String reason
    Date dateCreated
    Date lastUpdated


    static belongsTo = [application: Application]

    static constraints = {
    }

    String toString() {
        "${eventSource},${eventTarget} : ${reason} "
    }
}
