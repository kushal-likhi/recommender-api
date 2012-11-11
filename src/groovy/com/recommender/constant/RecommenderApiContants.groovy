package com.recommender.constant

import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

class RecommenderApiContants {
    public static final String HOST=CH.config.grails.mongo.host as String
    public static final String DBNAME=CH.config.grails.mongo.databaseName as String
    public static final Integer PORT=CH.config.grails.mongo.port as Integer
}
