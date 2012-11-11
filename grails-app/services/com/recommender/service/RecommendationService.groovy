package com.recommender.service

import org.apache.mahout.cf.taste.impl.model.mongodb.MongoDBDataModel
import com.recommender.constant.RecommenderApiContants
import org.apache.mahout.cf.taste.impl.recommender.CachingRecommender
import org.apache.mahout.cf.taste.impl.recommender.slopeone.SlopeOneRecommender
import org.apache.mahout.cf.taste.recommender.RecommendedItem
import com.recommender.domain.Application
import com.recommender.command.AppHitCo
import com.recommender.enums.AlgorithmType
import org.apache.mahout.cf.taste.similarity.UserSimilarity
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood
import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood
import org.apache.mahout.cf.taste.recommender.Recommender
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender
import org.apache.mahout.cf.taste.impl.similarity.EuclideanDistanceSimilarity
import org.apache.mahout.cf.taste.impl.recommender.svd.SVDRecommender
import org.apache.mahout.cf.taste.impl.recommender.svd.ALSWRFactorizer
import org.apache.mahout.cf.taste.impl.similarity.LogLikelihoodSimilarity

class RecommendationService {

    Map recommend(String appId, String target, String noOfRecommendations) {
        AppHitCo appHitCo = new AppHitCo(appId: appId, target: target, noOfRecommendations: noOfRecommendations)
        List<RecommendedItem> recommendationList = []
        switch (appHitCo.application.algorithm) {
            case AlgorithmType.SLOPEONE: recommendationList = slopeOneRecommender(appHitCo)
                break
            case AlgorithmType.PearsonCorrelationSimilarity: recommendationList = pearsonCorrelationSimilarity(appHitCo)
                break
            case AlgorithmType.EuclideanDistanceSimilarity: recommendationList = euclideanDistanceSimilarity(appHitCo)
                break
            case AlgorithmType.LogLikelihoodSimilarity: recommendationList = logLikelihoodSimilarity(appHitCo)
                break
            case AlgorithmType.SVD: recommendationList = sVDRecommender(appHitCo)
                break
            default: recommendationList = sVDRecommender(appHitCo)
        }
        for (RecommendedItem recommendedItem : recommendationList) {
            System.out.println(recommendedItem);
        }
        ['source': appHitCo.target, 'algorithm': appHitCo.application.algorithm?.name(), 'recommendations': recommendationList.collect {[item:it.itemID,weight:it.value]}]
    }

    List<RecommendedItem> slopeOneRecommender(AppHitCo appHitCo) {
        println 'SlopeOneRecommender ..........'
        String tableName = "events_${appHitCo.appId}"
        Long targetId = appHitCo.target.toLong()
        MongoDBDataModel model = new MongoDBDataModel(RecommenderApiContants.HOST, RecommenderApiContants.PORT, RecommenderApiContants.DBNAME, tableName, true, true, null);
        CachingRecommender cachingRecommender = new CachingRecommender(new SlopeOneRecommender(model));
        List recommendations = cachingRecommender.recommend(targetId, appHitCo.noOfRecommendations);
        return recommendations
    }


    List<RecommendedItem> pearsonCorrelationSimilarity(AppHitCo appHitCo) {
        println 'PearsonCorrelationSimilarity ..........'
        String tableName = "events_${appHitCo.appId}"
        Long targetId = appHitCo.target.toLong()
        MongoDBDataModel model = new MongoDBDataModel(RecommenderApiContants.HOST, RecommenderApiContants.PORT, RecommenderApiContants.DBNAME, tableName, true, true, null);
        UserSimilarity similarity = new PearsonCorrelationSimilarity(model);
        UserNeighborhood neighborhood = new NearestNUserNeighborhood(3, similarity, model);
        Recommender recommender = new GenericUserBasedRecommender(model, neighborhood, similarity);
        List<RecommendedItem> recommendations = recommender.recommend(targetId, appHitCo.noOfRecommendations);
        return recommendations
    }

    List<RecommendedItem> logLikelihoodSimilarity(AppHitCo appHitCo) {
        println 'logLikelihoodSimilarity ..........'
        String tableName = "events_${appHitCo.appId}"
        Long targetId = appHitCo.target.toLong()
        MongoDBDataModel model = new MongoDBDataModel(RecommenderApiContants.HOST, RecommenderApiContants.PORT, RecommenderApiContants.DBNAME, tableName, true, true, null);
        UserSimilarity similarity = new LogLikelihoodSimilarity(model);
        UserNeighborhood neighborhood = new NearestNUserNeighborhood(3, similarity, model);
        Recommender recommender = new GenericUserBasedRecommender(model, neighborhood, similarity);
        List<RecommendedItem> recommendations = recommender.recommend(targetId, appHitCo.noOfRecommendations);
        return recommendations
    }

    List<RecommendedItem> euclideanDistanceSimilarity(AppHitCo appHitCo) {
        println 'EuclideanDistanceSimilarity ..........'
        String tableName = "events_${appHitCo.appId}"
        Long targetId = appHitCo.target.toLong()
        MongoDBDataModel model = new MongoDBDataModel(RecommenderApiContants.HOST, RecommenderApiContants.PORT, RecommenderApiContants.DBNAME, tableName, true, true, null);
        UserSimilarity similarity = new EuclideanDistanceSimilarity(model);
        UserNeighborhood neighborhood = new NearestNUserNeighborhood(3, similarity, model);
        Recommender recommender = new GenericUserBasedRecommender(model, neighborhood, similarity);
        List<RecommendedItem> recommendations = recommender.recommend(targetId, appHitCo.noOfRecommendations);
        return recommendations
    }


    List<RecommendedItem> sVDRecommender(AppHitCo appHitCo) {
        println 'sVDRecommender ..........'
        String tableName = "events_${appHitCo.appId}"
//        String tableName = "mahoutTestData"
        Long targetId = appHitCo.target.toLong()
        MongoDBDataModel model = new MongoDBDataModel(RecommenderApiContants.HOST, RecommenderApiContants.PORT, RecommenderApiContants.DBNAME, tableName, true, true, null);
        SVDRecommender svd = new SVDRecommender(model, new ALSWRFactorizer(model, 3, 0.05f, 50));
        List recommendations = svd.recommend(targetId, appHitCo.noOfRecommendations);
        return recommendations
    }

}
