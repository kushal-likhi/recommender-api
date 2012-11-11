package com.recommender.dto

import com.recommender.domain.Application


class ApplicationStatsDto {
    String name
    String id
    Integer savedHits
    Integer failedHits
    Integer receivedHits
    String secretKey

    Integer totalHits(){
        Integer total = 0
        total=total + (savedHits?:0)
        total=total + (failedHits?:0)
        total=total + (receivedHits?:0)
        return total
    }

    ApplicationStatsDto(){

    }

    ApplicationStatsDto(Application application){
       id = application.id.toString()
       name = application.name
       secretKey = application.secretKey
    }
}
