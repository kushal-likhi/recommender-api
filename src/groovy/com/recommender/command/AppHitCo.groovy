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
        Application application = Application.get((new ObjectId(appId)) )
        (application && application.secretKey == secretKey) ? application : null
    }

    Integer getNoOfRecommendations(){
        return noOfRecommendations?noOfRecommendations.toInteger():1
    }


}
