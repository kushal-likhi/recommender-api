package com.recommender.service

import org.springframework.beans.factory.InitializingBean
import com.mongodb.Mongo
import com.mongodb.DB
import com.mongodb.DBCollection
import com.mongodb.BasicDBObject
import grails.converters.JSON
import org.bson.types.ObjectId
import com.recommender.domain.FailedData
import com.recommender.domain.Application
import com.recommender.util.RedisKeyBuilder


class EventService implements InitializingBean {

    static transactional = false

    def grailsApplication

    def redisService

    private static Mongo mongo

    static rabbitQueue = 'unsavedEvents'

    void handleMessage(String message) {
        def data = JSON.parse(message)
        try {
            saveEvent(data?.source, data?.target, data?.weight, data?.appId)
            redisService.withSingleConnection {
                incr(RedisKeyBuilder.buildEventSavedKey(data?.appId))
            }
        } catch (Exception e) {
            new FailedData(
                    eventSource: data?.source,
                    eventTarget: data?.target,
                    weight: (data?.weight) as String,
                    application: Application.get(ObjectId.isValid(data?.appId) ? new ObjectId(data?.appId?.toString()) : null),
                    reason: e.message
            ).save()
        }
    }

    boolean saveEvent(String source, String target, Integer weight, String appId) {
        if (source && target && weight && appId) {
            Map event = findPreviousEntry(source, target, weight, appId)
            DBCollection collection = fetchEventCollectionForApp(appId)
            BasicDBObject object = new BasicDBObject()
            object.put("_id", event ? event.id : new ObjectId())
            object.put("user_id", source)
            object.put("item_id", target)
            object.put("preference", event ? event.weight + weight : weight)
            collection.save(object)
        } else throw new Exception("Some event details are invalid")
        return true
    }

    DBCollection fetchEventCollectionForApp(String appId) {
        DB db = mongo.getDB(grailsApplication.config.grails.mongo.databaseName);
        db.getCollection("events_${appId}")
    }

    Map findPreviousEntry(String source, String target, Integer weight, String appId) {
        DBCollection collection = fetchEventCollectionForApp(appId)
        BasicDBObject object = new BasicDBObject()
        object.put("source", source)
        object.put("target", target)
        collection.findOne(object)?.toMap()
    }

    void afterPropertiesSet() {
        mongo = new Mongo(
                'localhost',
                27017
        )
    }
}
