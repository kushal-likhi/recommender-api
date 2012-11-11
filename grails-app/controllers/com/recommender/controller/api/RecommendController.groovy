package com.recommender.controller.api

import com.recommender.command.AppHitCo

class RecommendController {
    def recommendationService

    def recommend(AppHitCo appHitCo) {
        Map recommendations = [:]
        try {
            if (appHitCo.application) {
                recommendations = recommendationService.recommend(appHitCo)
            }
            render(recommendations)
        } catch (Exception e) {
            render "Bad request"
        }

    }
}
