package com.recommender.command

import com.recommender.domain.Application
import org.bson.types.ObjectId
import org.codehaus.groovy.grails.validation.Validateable


@Validateable
class AppHitCo {
    String appId
    String secretKey
    String target
    String noOfRecommendations

    Application getApplication() {
        return Application.get((new ObjectId(appId)) )
    }

    Integer getNoOfRecommendations(){
        return noOfRecommendations?noOfRecommendations.toInteger():1
    }


}
