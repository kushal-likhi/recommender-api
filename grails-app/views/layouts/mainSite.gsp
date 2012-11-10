<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="axleDefaultViewPort" content="body"/>
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114"
          href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <link href='http://fonts.googleapis.com/css?family=Allerta' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Istok+Web' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=PT+Sans' rel='stylesheet' type='text/css'>
    <jq:resources/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.axle.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.placeholder.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'tinybox.js')}"></script>
    <link type="text/css" rel="stylesheet" href="${resource(dir: 'css', file: 'tinybox2.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mainSite.css')}" type="text/css">
    <link type="text/plain" rel="axle" href="${resource(dir: 'css', file: 'mainSite.axle')}"/>
    <g:layoutHead/>
    <!--[if gte IE 9]>
        <style type="text/css">
            .gradient {
                filter: none;
            }
        </style>
        <![endif]-->
</head>

<body>
<img src="${resource(dir: 'images', file: 'stairway.jpg')}" id="bg_main"/>
<img id="logo" src="${resource(dir: 'images', file: 'logo.png')}"/>

<div id="footer_msg">&copy; Recommender API - All Rights Reserved.</div>

<div id="footer_share"><g:render template="/layouts/share"/></div>

<div id="nav_bar"><g:render template="/layouts/navBar"/></div>
<g:layoutBody/>

<div style="display: none;position: absolute;top:0;left:0" id="aboutPage">
    <div style="height:500px;width:700px;overflow: auto;">
        <h1>What is Recommender API?</h1>
        About the api and uses and clients here....
    </div>
</div>

<div style="display: none;position: absolute;top:0;left:0" id="apiDoc">
    <div style="height:500px;width:950px;overflow: auto;">
        <h1>API Documentation</h1>
        About the api here....
    </div>
</div>

<div style="display: none;position: absolute;top:0;left:0" id="loginForm">
    <table border="0" cellpadding="0" cellspacing="0" width="700px" height="220px"
           style="width:700px;height:220px" class="popup gradient">
        <tr style="font-size: 14px;">
            <th>Login</th>
            <th>&nbsp;</th>
            <th>Register</th>
        </tr>
        <tr>
            <td align="center" valign="middle" style="text-align: center;vertical-align: middle;" width="345px">
                <div style="font-size: 10px;color:red;" id="loginErrorFlashError">&nbsp;</div>

                <form id="loginFormActual"
                      action="${createLink(controller: 'security', action: 'authenticate')}">
                    <input class="required" type="text" name="username" placeholder="Username"/><br/>
                    <input class="required" type="password" name="password" placeholder="Password"/><br/>
                    <input class="" type="checkbox" name="remember"/>&nbsp;Remember Me<br/>
                    <span><a id="forgotPass" href="#">Forgot Password</a></span><br/><br/>
                    <button type="submit">Login</button>
                </form>
            </td>
            <td align="center" valign="middle" style="text-align: center;vertical-align: middle;">
                |<br/>
                |<br/>
                |<br/>
                |<br/>
                |<br/>
                |<br/>
                |<br/>
                |<br/>
            </td>
            <td align="center" valign="middle" style="text-align: center;vertical-align: middle;"
                width="345px">
                <div style="font-size: 10px;color:red;" id="registerErrorFlashError">&nbsp;</div>

                <form id="registerFormActual" action="${createLink(controller: 'security', action: 'createUser')}">
                    <input class="required" type="text" name="firstName" placeholder="First Name"/><br/>
                    <input class="required" type="text" name="lastName" placeholder="Last Name"/><br/>
                    <input class="required email" type="text" name="email" placeholder="Email"/><br/>
                    <button type="submit">Register</button>
                </form>
            </td>
        </tr>
    </table>
</div>

<div style="display: none;position: absolute;top:0;left:0" id="forgotPassword">
    <div style="text-align: left;font-weight: bold;font-size: 18px">Forgot Password</div>
    <g:form name="forgotPasswordForm" controller="security" action="forgotPassword">
        <table border="0" cellpadding="0" cellspacing="0" width="500px" height="100px" class="popup gradient">
            <tr style="font-size: 14px;">
                <th>Email</th>
                <th>
                    : <input type="text" name="email" value=""/>
                </th>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td style="text-align: center"><g:submitButton name="submit" value="Submit"/></td>
            </tr>
        </table>
    </g:form>
</div>

<script type="text/javascript">
    window.loginFormHtml = jQuery("#loginForm").html();
    window.aboutPageHTML = jQuery("#aboutPage").html();
    window.apiDocHTML = jQuery("#apiDoc").html();
    window.forgotPasswordHtml = jQuery("#forgotPassword").html();
    jQuery("#loginForm").remove();
    $("#loginNavItem").live('click', function () {
        TINY.box.show({
            html:window.loginFormHtml,
            animate:true,
            close:true,
            openjs:function () {
                jQuery("#loginFormActual").validate({
                    invalidHandler:function (form, validator) {
                    }
                });
                jQuery("#registerFormActual").validate({
                    invalidHandler:function (form, validator) {
                    }
                });
            }
        });
        return false;
    });
    $("#docsNavItem").live('click', function () {
        TINY.box.show({
            html:window.apiDocHTML,
            animate:true,
            close:true,
            openjs:function () {
            }
        });
        return false;
    });
    $("#aboutNavItem").live('click', function () {
        TINY.box.show({
            html:window.aboutPageHTML,
            animate:true,
            close:true,
            openjs:function () {
            }
        });
        return false;
    });
    $("#forgotPass").live('click', function () {
        TINY.box.show({
            html:window.forgotPasswordHtml,
            animate:true,
            close:true,
            openjs:function () {
            }
        });
        return false;
    });

    <g:if test="${flash.userInvalid}">
    TINY.box.show({
        html:window.loginFormHtml,
        animate:true,
        close:true,
        openjs:function () {
            jQuery("#loginFormActual").validate({
                invalidHandler:function (form, validator) {
                }
            });
            jQuery("#registerFormActual").validate({
                invalidHandler:function (form, validator) {
                }
            });
            $("#loginErrorFlashError").text("${flash.userInvalid}");
        }
    });
    </g:if>
    <g:if test="${flash.userCreateMessage}">
    TINY.box.show({
        html:"${flash.userCreateMessage.encodeAsJavaScript()}",
        animate:true,
        close:true
    });
    </g:if>
    <g:if test="${flash.forgotPasswordMsg}">
    TINY.box.show({
        html:"${flash.forgotPasswordMsg.encodeAsJavaScript()}",
        animate:true,
        close:true
    });
    </g:if>
    <g:if test="${flash.userCreateErrorMessage}">
    TINY.box.show({
        html:window.loginFormHtml,
        animate:true,
        close:true,
        openjs:function () {
            jQuery("#loginFormActual").validate({
                invalidHandler:function (form, validator) {
                }
            });
            jQuery("#registerFormActual").validate({
                invalidHandler:function (form, validator) {
                }
            });
            $("#registerErrorFlashError").text("${flash.userCreateErrorMessage}");
        }
    });
    </g:if>
</script>
</body>
</html>