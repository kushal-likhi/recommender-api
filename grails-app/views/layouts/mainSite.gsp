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
    <img style="cursor: pointer" onclick="window.location.href = '${createLink(uri:'/')}'" id="logo"
         src="${resource(dir: 'images', file: 'logo.png')}"/>

    <div id="footer_msg">&copy; Recommender API - All Rights Reserved.</div>

    <div id="footer_share"><g:render template="/layouts/share"/></div>

    <div id="nav_bar"><g:render template="/layouts/navBar"/></div>
    <g:layoutBody/>

    <div style="display: none;position: absolute;top:0;left:0" id="aboutPage">
        <div style="height:500px;width:700px;overflow: auto;">
            <h1>What is Recommender API?</h1>

            <p>
                Recommender API is built to provide you with intelligent recommendations for your users/consumers.
            </p>

            <p>
            <h4 style="margin-bottom: 0">Technology</h4>
            <hr/>
            Our <strong>Recommendation Engine</strong> is built around cutting edge technologies like <strong>Apache Mahout</strong> and datastores like <strong>MongoDB</strong> and <strong>Redis</strong>. We also maintain producer consumer queues such that the users can push data at whatever rate they want.
        </p>
            <p>
            <h4 style="margin-bottom: 0">Scalability and Reliability</h4>
            <hr/>
            The Application is built to be super secured and works stateless such that it can be scaled over thousands of machines rapidly whenever required. With this horizontal scalability, there also comes in a reliability as there is always a backup worker for each node.
        </p>
            <p>
            <h4 style="margin-bottom: 0">Who can use it?</h4>
            <hr/>
            Anyone who wants to provide intelligent recommendations based on the trends and data of your sources can use this API. Few tipical use cases are:
            <ul>
                <li><strong>E-Commerce sites</strong>: Recommend products to user based on his/her behaviour</li>
                <li><strong>Dating sites</strong>: Recommend the best match to the user</li>
                <li><strong>Medical diagnosis</strong>: Based on decease trends of a user future or possible deceases could be found
                </li>
                <li><strong>Failure prediction</strong>: Based on current equipment failures we can get recommendation on what could fail next
                </li>
                <li>And Many more....</li>
            </ul>
        </p>
        </div>
    </div>

    <div style="display: none;position: absolute;top:0;left:0" id="apiDoc">
        <div style="height:500px;width:950px;overflow: auto;">
            <h1>API Documentation</h1>
            Welcome to the Recommender API.
            <p>
            <h4 style="margin-bottom: 0">Obtaining the App ID and Key</h4>
            <hr/>
            You have to register and log in to your dashboard in order to create an application. Once the application is completed you will get the Api Key and App Id. You can see these keys for all of your applications in your dashboard anytime.
        </p>
            <p>
            <h4 style="margin-bottom: 0">The API Methods</h4>
            <hr/>
            This API is very simple to use and has only 2 methods:
            <ol>
                <li><b>Report event:</b> This API method is used to receive the event data. The System maintains and constantly enriches its data based on these events reported.
                </li>
                <li><b>Get Recommendation:</b> This method gives you the recommendations.</li>
            </ol>
            Each of these are explained in details below.
        </p>
            <p>
            <h4 style="margin-bottom: 0">Reporting Events</h4>
            <hr/>
            Using this you can report events to our system, based on which we populate the data set using which recommendations are made:
            <ul>
                <li><b>URL:</b> ${grailsApplication.config.grails.serverURL}/api/rest/<b>[your appId here]</b>/event/report
                </li>
                <li><b>Method:</b> POST</li>
                <li><b>Headers:</b> You need to add an authenticating header named <b>"auth-secret"</b> with your secret as its value
                </li>
                <li><b>Body:</b> In the body of the POST request, you need to provide us the JSON containing: <em>{"source": long_id_of_event_source, "target": long_id_of_event_source, "weight": float_number_for_event_importance}</em>
                </li>
            </ul>
            You must be wondering what events are, Let us explain you using the example of a dating site:<br/>
            Now lets assume that there are these many possible events on a dating site:
            <ol>
                <li>Visits a profile</li>
                <li>Likes a profile</li>
                <li>Shortlist a profile</li>
                <li>Ask for a date</li>
            </ol>
            In all of these events there is a user which is a source of the event, and there is a user who is a target of the event. e.x. userA(Source) likes profile of userB(Target)
            <br/>
            <br/>
            Now each of these events have a relative weightage in defining the interest of the source in target. Hence now putting that weightage to the events, they look like:
            <ol>
                <li>Visits a profile - 1 (Visiting a profile is of importance 1)</li>
                <li>Likes a profile - 2 (Liking a profile source shows double the interest as compared to visiting)</li>
                <li>Shortlist a profile - 5 (It means a great interest in the target)</li>
                <li>Ask for a date - 10 (this shows at least double interest than shortlisting)</li>
            </ol>
            <b>NOTE:</b> Weightage scale and values can be decided by you freely. You can play with these values in order to improve the recommendations.
            <br/>
            <br/>
            Now as these events occur, you will just report us these events with their weightage, and we will keep on developing the intelligent data set.

        </p>
            <p>
            <h4 style="margin-bottom: 0">Getting Recommendations</h4>
            <hr/>
            Using this you can get the recommendations for your source:
            <ul>
                <li><b>URL:</b> ${grailsApplication.config.grails.serverURL}/api/rest/<b>[your appId here]</b>/recommend
                </li>
                <li><b>Method:</b> GET</li>
                <li><b>Headers:</b> You need to add an authenticating header named <b>"auth-secret"</b> with your secret as its value
                </li>
                <li><b>Params:</b> In the URL params you need to pass two things: source(Long id of the event source) and count(Number of recommendations you need)
                </li>
            </ul>
            <b>Response will be like:</b><br/>
            <pre>
                {
                    "source": 232
                    "algorithm": "PearsonCorrelationSimilarity"
                    "recommendations": [
                                            {
                                                "item": 78,
                                                "weight": 1.33
                                            },
                                            {
                                                "item": 753,
                                                "weight": 1.98
                                            }
                                       [
                }
            </pre>

        </p>
            <p>
            <h4 style="margin-bottom: 0">The HTTP Error Codes</h4>
            <hr/>
            Following are the HTTP Status codes used by the API:
            <ol>
                <li><b>200</b>: Successfully processed your request and response available.</li>
                <li><b>201</b>: Successfully created an entry.</li>
                <li><b>401</b>: Invalid Secret Key.</li>
                <li><b>403</b>: Invalid Application Id.</li>
                <li><b>422</b>: Invalid Request params.</li>
                <li><b>500</b>: We were unable to process your request. Internal Server Error.</li>
            </ol>

        </p>
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

                    <form id="registerFormActual"
                          action="${createLink(controller: 'security', action: 'createUser')}">
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