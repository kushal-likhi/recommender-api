package com.recommender.enums


enum AlgorithmType {
    PearsonCorrelationSimilarity("PearsonCorrelationSimilarity"),
    EuclideanDistanceSimilarity("EuclideanDistanceSimilarity"),
    LogLikelihoodSimilarity("LogLikelihoodSimilarity"),
    SLOPEONE("SLOPEONE"),
    SVD("SVD")
    String value;

    AlgorithmType(String value) {
        this.value = value;
    }

    public static List list() {
        [PearsonCorrelationSimilarity, EuclideanDistanceSimilarity, LogLikelihoodSimilarity, SLOPEONE,SVD]
    }

}
