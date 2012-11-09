package com.recommender.enums


enum AlgorithmType {
    PearsonCorrelationSimilarity("PearsonCorrelationSimilarity"),
    EuclideanDistanceSimilarity("EuclideanDistanceSimilarity"),
    LogLikelihoodSimilarity("LogLikelihoodSimilarity"),
    SlopeOneRecommender("SlopeOneRecommender")

    String value;

    AlgorithmType(String value) {
        this.value = value;
    }

    public static List list() {
        [PearsonCorrelationSimilarity, EuclideanDistanceSimilarity, LogLikelihoodSimilarity, SlopeOneRecommender]
    }

}
