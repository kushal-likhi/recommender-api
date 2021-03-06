<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
    <g:layoutHead/>
</head>

<body>
<div style="width: 90%;margin: 0 auto;">
<div id="grailsLogo" role="banner" style="margin-top: 10px;"><a href="${createLink(uri: '/')}"><img id="logo"
                                                                                                    src="${resource(dir: 'images', file: 'logo.png')}"/>
</a>

    <div style="text-align: right;margin-right: 20px;margin-bottom: 5px;"><b>Welcome <g:loggedInUserName/>!</b></div>
</div>
<g:render template="/layouts/menu"/>
<g:if test="${flash.message}">
    <div style="border: 1px solid #008ee8;text-align: left;margin-left: 20px;margin-right: 20px; color: #00008B;">${flash.message}</div>
</g:if>
<g:layoutBody/>
<div id="footer_msg">&copy; Recommender API - All Rights Reserved.</div>

<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
<g:javascript library="application"/>
</div>
</body>
</html>