package com.recommender.service

import com.mongodb.DBCursor
import com.recommender.domain.Application
import com.recommender.dto.ApplicationDataDto

class ApplicationService {

    def eventService

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


}
