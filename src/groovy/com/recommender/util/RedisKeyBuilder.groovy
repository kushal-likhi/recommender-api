package com.recommender.util


class RedisKeyBuilder {

    public static String buildEventReceivedKey(String appId) {
        "rawRecieved_${appId}"
    }

    public static String buildEventSavedKey(String appId) {
        "rawSaved_${appId}"
    }

    public static String buildEventFailedToBeReceivedKey(String appId) {
        "rawSaved_${appId}"
    }

    public static String buildRecommendationRequestKey(String appId) {
        "recommendationRequest_${appId}"
    }

    public static String buildRecommendationFailedKey(String appId) {
        "recommendationFailed_${appId}"
    }

}
