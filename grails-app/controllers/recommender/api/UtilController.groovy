package recommender.api

import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood
import org.apache.mahout.cf.taste.impl.recommender.CachingRecommender
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity

import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood
import org.apache.mahout.cf.taste.recommender.RecommendedItem
import org.apache.mahout.cf.taste.recommender.Recommender
import org.apache.mahout.cf.taste.similarity.UserSimilarity

import org.apache.mahout.cf.taste.impl.similarity.EuclideanDistanceSimilarity

import org.apache.mahout.cf.taste.impl.recommender.slopeone.SlopeOneRecommender

import org.apache.mahout.cf.taste.impl.model.mongodb.MongoDBDataModel
import org.apache.mahout.cf.taste.impl.recommender.svd.ALSWRFactorizer
import org.apache.mahout.cf.taste.impl.recommender.svd.SVDRecommender
import com.recommender.constant.RecommenderApiContants

import com.recommender.command.AppHitCo

import com.recommender.domain.MahoutTestData

class UtilController {
    def recommendationService

    def recommend(AppHitCo appHitCo) {

//        if (appHitCo.application) {
//            recommendationService.recommend(appHitCo)
//        }

        println '----------------------------------------------------------------------------------------'
        SlopeOneRecommender()
        PearsonCorrelationSimilarity()
        EuclideanDistanceSimilarity()
        SVDRecommender()

    }



    def SlopeOneRecommender() {
        println 'SlopeOneRecommender ..........'



        String tableName = "ratings"
        String userIdInString = "509e2e711980ec6fd3744d9c"


        MongoDBDataModel model = new MongoDBDataModel(RecommenderApiContants.HOST, RecommenderApiContants.PORT, RecommenderApiContants.DBNAME, tableName, true, true, null);
        Long userId = model.fromIdToLong(userIdInString, true).toLong()     //  if userId comes in form of objectId then it is required otherwise we need to covert it into long only
        CachingRecommender cachingRecommender = new CachingRecommender(new SlopeOneRecommender(model));
        List recommendations = cachingRecommender.recommend(userId, 1);
        for (RecommendedItem recommendedItem : recommendations) {
            System.out.println(recommendedItem);
        }


    }

    def PearsonCorrelationSimilarity() {
        println 'PearsonCorrelationSimilarity ..........'

        String tableName = "ratings"
        String userIdInString = "509e2e711980ec6fd3744d9c"


        MongoDBDataModel model = new MongoDBDataModel(RecommenderApiContants.HOST, RecommenderApiContants.PORT, RecommenderApiContants.DBNAME, tableName, true, true, null,);
        Long userId = model.fromIdToLong(userIdInString, true).toLong()
        UserSimilarity similarity = new PearsonCorrelationSimilarity(model);
        UserNeighborhood neighborhood = new NearestNUserNeighborhood(3, similarity, model);
        Recommender recommender = new GenericUserBasedRecommender(model, neighborhood, similarity);
        List<RecommendedItem> recommendations = recommender.recommend(userId, 1);
        for (RecommendedItem recommendation : recommendations) {
            System.out.println(recommendation);
        }
    }

    def EuclideanDistanceSimilarity() {
        println 'EuclideanDistanceSimilarity ..........'
        String tableName = "ratings"
        String userIdInString = "509e2e711980ec6fd3744d9c"


        MongoDBDataModel model = new MongoDBDataModel(RecommenderApiContants.HOST, RecommenderApiContants.PORT, RecommenderApiContants.DBNAME, tableName, true, true, null);
        Long userId = model.fromIdToLong(userIdInString, true).toLong()
        UserSimilarity similarity = new EuclideanDistanceSimilarity(model);
        UserNeighborhood neighborhood = new NearestNUserNeighborhood(3, similarity, model);
        Recommender recommender = new GenericUserBasedRecommender(model, neighborhood, similarity);
        List<RecommendedItem> recommendations = recommender.recommend(userId.toLong(), 1);
        for (RecommendedItem recommendation : recommendations) {
            System.out.println(recommendation);
        }
    }

    def SVDRecommender() {
        println 'SVDRecommender ..........'
        String tableName = "ratings"
        String userIdInString = "509e2e711980ec6fd3744d9c"


        MongoDBDataModel model = new MongoDBDataModel(RecommenderApiContants.HOST, RecommenderApiContants.PORT, RecommenderApiContants.DBNAME, tableName, true, true, null);
        Long userId = model.fromIdToLong(userIdInString, true).toLong()
        SVDRecommender svd = new SVDRecommender(model, new ALSWRFactorizer(model, 3, 0.05f, 50));
        List recommendations = svd.recommend(userId, 1);
        for (RecommendedItem recommendedItem : recommendations) {
            System.out.println(recommendedItem);
        }
    }


    def getDataFromTextFile() {
        File file = new File('/home/shaurav/Desktop/libimseti/ratings.dat')
        def words
        file.eachLine {line ->
            words = line.split(",")
            new MahoutTestData(user_id: words[0].toLong(), item_id: words[1].toLong(), preference: words[2].toFloat()).save(flush: true)
        }
        render 'completed'
    }
}
