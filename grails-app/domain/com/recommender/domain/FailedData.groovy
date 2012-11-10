package com.recommender.domain

class FailedData {

    String eventSource
    String eventTarget
    String weight

    String reason
    Date dateCreated
    Date lastUpdated


    static belongsTo = [application: Application]

    static constraints = {
        eventSource(nullable: true, blank: true)
        eventTarget(nullable: true, blank: true)
        weight(nullable: true, blank: true)
        reason(nullable: true, blank: true)
    }

    String toString() {
        "${eventSource},${eventTarget} : ${reason} "
    }
}
