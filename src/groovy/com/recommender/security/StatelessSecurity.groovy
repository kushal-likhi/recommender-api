package com.recommender.security

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import cr.co.arquetipos.crypto.Blowfish
import javax.servlet.http.Cookie


@Singleton
class StatelessSecurity {

    private final String SESSION_COOKIE_NAME = "GSESSIONHASH"
    private final String REMEMBER_ME_COOKIE_NAME = "REMEMBERMEHASH"
    private final Integer SESSION_TIMEOUT = 30 * 60
    private final Integer REMEMBER_ME_TIMEOUT = 30 * 24 * 60 * 60
    private final SECRET_KEY = "sdjnv39i84yfg343vg4oFEGREg435gRG5345nf3948ytfrigbc3iogf3gffwregfrewgrryw43drhvaase4"

    public static boolean enrichRequest(HttpServletRequest request, HttpServletResponse response) {
        request.currentUser = getInstance().verifyAndExtractUserId(getInstance().getSessionCookie(request) ?: getInstance().getRememberMeCookie(request) ?: null, request)
        if (request.currentUser) getInstance().refreshCookies(request, response)
        true
    }

    public static boolean createSessionForUser(HttpServletRequest request, HttpServletResponse response, String userId) {
        request.currentUser = userId
        getInstance().refreshCookies(request, response)
        true
    }

    public static boolean createRememberMeCookie(HttpServletRequest request, HttpServletResponse response, String userId) {
        request.rememberMeSet = true
        getInstance().refreshRememberCookie(request, response)
        true
    }

    public static boolean destroyUserSession(HttpServletRequest request, HttpServletResponse response) {
        request.currentUser = null
        getInstance().destroySession(response)
        true
    }

    public String getSessionCookie(HttpServletRequest request) {
        request.cookies.find {it.name == SESSION_COOKIE_NAME}?.value
    }

    public String getRememberMeCookie(HttpServletRequest request) {
        request.cookies.find {it.name == REMEMBER_ME_COOKIE_NAME}?.value
    }

    public String verifyAndExtractUserId(String cookie, HttpServletRequest request) {
        if (!cookie) return null
        try {
            List tokens = Blowfish.decryptBase64(cookie, SECRET_KEY).tokenize("||")
            if(tokens.size() != 5) throw new Exception("Invalid number of tokens")
            if (tokens[1].toString().toLong() - new Date().getTime() < 0) throw new Exception("Token Expired")
            if (!tokens[2].toString().equals(request.getHeader('user-agent').encodeAsSHA256())) throw new Exception("Cookie has been copied")
            if (!tokens[3].toString().equals("${tokens[0]}||${tokens[1]}||${tokens[2]}".encodeAsMD5())) throw new Exception("Cookie Tampered")
            if (!tokens[4].toString().equals("${tokens[0]}||${tokens[1]}||${tokens[2]}||${tokens[3]}".encodeAsSHA256())) throw new Exception("Signeture mismatch")
            return tokens[0]
        } catch (e) {
            println e.message
            println e.getStackTrace()
            return null
        }
    }

    public void refreshCookies(HttpServletRequest request, HttpServletResponse response) {
        refreshSessionCookie(request, response)
    }

    void refreshSessionCookie(HttpServletRequest request, HttpServletResponse response) {
        if (!request.currentUser) return
        String value = "${request.currentUser}||${new Date().getTime() + (SESSION_TIMEOUT * 1000)}||${request.getHeader('user-agent').encodeAsSHA256()}";
        value += "||" + value.encodeAsMD5()
        value += "||" + value.encodeAsSHA256()
        value = Blowfish.encryptBase64(value.getBytes(), SECRET_KEY)
        Cookie cookie = new Cookie(SESSION_COOKIE_NAME, value)
        cookie.maxAge = SESSION_TIMEOUT
        response.addCookie(cookie)
    }

    void refreshRememberCookie(HttpServletRequest request, HttpServletResponse response) {
        if(!request.rememberMeSet) return
        if (!request.currentUser) return
        String value = "${request.currentUser}||${new Date().getTime() + (REMEMBER_ME_TIMEOUT * 1000)}||${request.getHeader('user-agent').encodeAsSHA256()}";
        value += "||" + value.encodeAsMD5()
        value += "||" + value.encodeAsSHA256()
        value = Blowfish.encryptBase64(value.getBytes(), SECRET_KEY)
        Cookie cookie = new Cookie(REMEMBER_ME_COOKIE_NAME, value)
        cookie.maxAge = REMEMBER_ME_TIMEOUT
        response.addCookie(cookie)
    }

    void destroySession(HttpServletResponse response){
        Cookie cookie = new Cookie(SESSION_COOKIE_NAME, "")
        cookie.maxAge = 0
        response.addCookie(cookie)
        Cookie cookieRM = new Cookie(REMEMBER_ME_COOKIE_NAME, "")
        cookie.maxAge = 0
        response.addCookie(cookieRM)
    }
}
