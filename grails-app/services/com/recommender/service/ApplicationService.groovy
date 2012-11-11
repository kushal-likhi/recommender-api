package com.recommender.service

import com.mongodb.DBCursor
import com.recommender.domain.Application
import com.recommender.domain.User
import com.recommender.dto.ApplicationDataDto
import com.recommender.dto.ApplicationStatsDto
import com.recommender.util.RedisKeyBuilder

class ApplicationService {

    def eventService
    def redisService

    Map getAppStatsData(Application application) {
        Map result = [:]
        List applicationDataDtos = applicationTableData(application)
        Map applicationStatsData = applicationDataDtos.groupBy {it.value}
        applicationStatsData?.keySet()?.each { String key ->
            result[key] = applicationStatsData[key]*.weight.sum()
        }
        return result
    }

    List<ApplicationDataDto> applicationTableData(Application application) {
        DBCursor cur
        cur = eventService.fetchEventCollectionForApp(application.id.toString()).find()
        List list = []
        while (cur && cur.hasNext()) {
            Map props = cur.next().toMap()
            list.add(new ApplicationDataDto(value: props.target, weight: props.weight.toInteger()))
        }
        list
    }

    List<ApplicationStatsDto> getAppiclationsDataStats(User user) {
        List result = []
        redisService.withSingleConnection {
            user.applications.each {Application application ->
                ApplicationStatsDto applicationStatsDto = new ApplicationStatsDto(application)
                applicationStatsDto.savedHits = get(RedisKeyBuilder.buildEventSavedKey(applicationStatsDto.id))?.toInteger()
                applicationStatsDto.failedHits = get(RedisKeyBuilder.buildEventFailedToBeReceivedKey(applicationStatsDto.id))?.toInteger()
                applicationStatsDto.receivedHits = get(RedisKeyBuilder.buildEventReceivedKey(applicationStatsDto.id))?.toInteger()
                result.add(applicationStatsDto)
            }
        }
        return result
    }


}
