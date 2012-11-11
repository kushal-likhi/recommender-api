package com.recommender.controller.api

import grails.converters.JSON
import com.recommender.domain.Application
import org.bson.types.ObjectId
import org.codehaus.groovy.grails.web.json.JSONObject
import com.recommender.util.RedisKeyBuilder

class RestApiController {

    static allowedMethods = [reportEvent: 'POST', recommend: 'GET']

    def redisService
    def recommendationService

    /*
    Needs Secret key in header "auth-secret"
    Data in body, JSON of [source, target, weight]
    appId in url
     */
    def reportEvent(String appId) {
        String respMessage
        int respCode
        try {
            String key = request.getHeader('auth-secret')
            JSONObject data = JSON.parse(request) as JSONObject
            Application application = Application.get(new ObjectId(appId))
            if (application) {
                if (application.secretKey.equals(key)) {
                    if (data) {
                        data.put("appId", appId)
                        rabbitSend('unsavedEvents', (data as JSON) as String)
                        redisService.withSingleConnection {
                            incr(RedisKeyBuilder.buildEventReceivedKey(appId))
                        }
                        respMessage = ([success: "Data Recieved Sucessfully"] as JSON)
                        respCode = 201
                    } else {
                        respMessage = ([error: "Invalid Data"] as JSON)
                        respCode = 422
                    }
                } else {
                    respMessage = ([error: "Invalid Secret Key"] as JSON)
                    respCode = 401
                }
            } else {
                respMessage = ([error: "Invalid Application Id"] as JSON)
                respCode = 403
            }
        } catch (Exception exception) {
            redisService.withSingleConnection {
                incr(RedisKeyBuilder.buildEventFailedToBeReceivedKey(appId))
            }
            respMessage = ([error: "We were unable to process your request"] as JSON)
            respCode = 500
            log.error(exception)
        }
        response.setStatus(respCode)
        render(respMessage)
    }

    /*
    Needs Secret key in header "auth-secret"
    Data in params, JSON of [source, count]
    appId in url
     */
    def recommend(String appId, String source, Integer count) {
        String respMessage
        int respCode
        try {
            String key = request.getHeader('auth-secret')
            Application application = Application.get(new ObjectId(appId))
            if (application) {
                if (application.secretKey.equals(key)) {
                    if (source && count) {
                        respMessage = ([recommendations: recommendationService.recommend(appId,source,count.toString())] as JSON)
                        respCode = 201
                        redisService.withSingleConnection {
                            incr(RedisKeyBuilder.buildRecommendationRequestKey(appId))
                        }
                    } else {
                        respMessage = ([error: "Invalid Request params"] as JSON)
                        respCode = 422
                    }
                } else {
                    respMessage = ([error: "Invalid Secret Key"] as JSON)
                    respCode = 401
                }
            } else {
                respMessage = ([error: "Invalid Application Id"] as JSON)
                respCode = 403
            }
        } catch (Exception exception) {
            redisService.withSingleConnection {
                incr(RedisKeyBuilder.buildRecommendationFailedKey(appId))
            }
            respMessage = ([error: "We were unable to process your request"] as JSON)
            respCode = 500
            log.error(exception)
        }
        response.setStatus(respCode)
        render(respMessage)
    }
}
