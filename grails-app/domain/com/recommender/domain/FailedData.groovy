package com.recommender.domain

class FailedData {

    String eventSource
    String eventTarget
    Integer weight

    String reason

    static belongsTo = [application: Application]

    static constraints = {
    }
}
