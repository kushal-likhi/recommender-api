package com.recommender.service

class OurMailService {

    static transactional = false

    def groovyPageRenderer
    def mailService

    void sendMail(String _to, String _subject, String template, Map model) {
        mailService.sendMail {
            to(_to)
            subject(_subject)
            html(groovyPageRenderer.render(template: "/mailTemplate/${template}", model: model))
        }
    }
}
