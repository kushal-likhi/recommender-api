package recommender.api



import org.apache.mahout.cf.taste.common.TasteException
import org.apache.mahout.cf.taste.impl.model.file.FileDataModel
import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood
import org.apache.mahout.cf.taste.impl.recommender.CachingRecommender
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity
import org.apache.mahout.cf.taste.model.DataModel
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood
import org.apache.mahout.cf.taste.recommender.RecommendedItem
import org.apache.mahout.cf.taste.recommender.Recommender
import org.apache.mahout.cf.taste.similarity.UserSimilarity
import org.apache.mahout.cf.taste.impl.model.jdbc.MySQLJDBCDataModel
import org.apache.mahout.cf.taste.impl.similarity.EuclideanDistanceSimilarity
import org.apache.mahout.cf.taste.similarity.ItemSimilarity
import org.apache.mahout.cf.taste.impl.recommender.slopeone.SlopeOneRecommender
import org.apache.mahout.cf.taste.impl.similarity.SpearmanCorrelationSimilarity
import org.apache.mahout.cf.taste.impl.similarity.CachingUserSimilarity
import org.apache.mahout.cf.taste.impl.similarity.LogLikelihoodSimilarity
import org.apache.mahout.cf.taste.impl.model.mongodb.MongoDBDataModel
import org.apache.mahout.cf.taste.impl.recommender.svd.ALSWRFactorizer
import org.apache.mahout.cf.taste.impl.recommender.svd.SVDRecommender

class UtilController {
    def dataSource

    def MahoutPlaying() {
        println '----------------------------------------------------------------------------------------'
        SlopeOneRecommender()
        PearsonCorrelationSimilarity()
        EuclideanDistanceSimilarity()
        SVDRecommender()

    }

    def SlopeOneRecommender() {
        println 'SlopeOneRecommender ..........'
        MongoDBDataModel model = new MongoDBDataModel("127.0.0.1", 27017, "test", "ratings", true, true, null);
        String userId = model.fromIdToLong('509e2e711980ec6fd3744d9c', true)
        CachingRecommender cachingRecommender = new CachingRecommender(new SlopeOneRecommender(model));
        List recommendations = cachingRecommender.recommend(userId.toLong(), 1);
        for (RecommendedItem recommendedItem : recommendations) {
            System.out.println(recommendedItem);
        }
    }
    def PearsonCorrelationSimilarity() {
        println 'PearsonCorrelationSimilarity ..........'
        MongoDBDataModel model = new MongoDBDataModel("127.0.0.1", 27017, "test", "ratings", true, true, null);
        String userId = model.fromIdToLong('509e2e711980ec6fd3744d9c', true)
        UserSimilarity similarity = new PearsonCorrelationSimilarity(model);
        UserNeighborhood neighborhood = new NearestNUserNeighborhood(3, similarity, model);
        Recommender recommender = new GenericUserBasedRecommender(model, neighborhood, similarity);
        List<RecommendedItem> recommendations = recommender.recommend(userId.toLong(), 1);
        for (RecommendedItem recommendation : recommendations) {
            System.out.println(recommendation);
        }
    }

    def EuclideanDistanceSimilarity() {
        println 'EuclideanDistanceSimilarity ..........'
        MongoDBDataModel model = new MongoDBDataModel("127.0.0.1", 27017, "test", "ratings", true, true, null);
        String userId = model.fromIdToLong('509e2e711980ec6fd3744d9c', true)
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
        MongoDBDataModel model = new MongoDBDataModel("127.0.0.1", 27017, "test", "ratings", true, true, null);
        SVDRecommender svd = new SVDRecommender(model, new ALSWRFactorizer(model, 3, 0.05f, 50));
        String userId = model.fromIdToLong('509e2e711980ec6fd3744d9c', true)
        List recommendations = svd.recommend(userId.toLong(), 1);
        for (RecommendedItem recommendedItem : recommendations) {
            System.out.println(recommendedItem);
        }
    }


}
