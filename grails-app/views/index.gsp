<html>
    <head>
        <meta name="layout" content="mainSite"/>
        <title>Recommender API</title>

    </head>

    <body>
        <div id="powered_by">
            Powered By:
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="90%" style="width:100%;height:90%">
                <tr>
                    <td width="14.28%" align="center"><img height="40px"
                                                           src="${resource(dir: 'images', file: 'cloud.png')}" alt=""/>
                    </td>
                    <td width="14.28%" align="center"><img height="40px"
                                                           src="${resource(dir: 'images', file: 'grails.png')}" alt=""/>
                    </td>
                    <td width="14.28%" align="center"><img height="40px"
                                                           src="${resource(dir: 'images', file: 'mahaout.png')}"
                                                           alt=""/></td>
                    <td width="14.28%" align="center"><img height="35px"
                                                           src="${resource(dir: 'images', file: 'hadoop.png')}" alt=""/>
                    </td>
                    <td width="14.28%" align="center"><img height="35px"
                                                           src="${resource(dir: 'images', file: 'redis.png')}" alt=""/>
                    </td>
                    <td width="14.28%" align="center"><img height="40px"
                                                           src="${resource(dir: 'images', file: 'mongo.png')}" alt=""/>
                    </td>
                    <td width="14.28%" align="center"><img height="30px"
                                                           src="${resource(dir: 'images', file: 'rabbit.png')}" alt=""/>
                    </td>
                </tr>
            </table>
        </div>

        <div id="features">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="90%" style="width:100%;height:90%">
                <tr>
                    <td><img src="${resource(dir: 'images', file: 'check.png')}" height="16px"
                             alt=""/>Scalable Cluster over cloud</td>
                    <td><img src="${resource(dir: 'images', file: 'check.png')}" height="16px"
                             alt=""/>Fast response time for data pushes</td>
                    <td><img src="${resource(dir: 'images', file: 'check.png')}" height="16px"
                             alt=""/>Ability to select/change algorithms anytime as per your needs</td>
                </tr>
                <tr>
                    <td><img src="${resource(dir: 'images', file: 'check.png')}" height="16px"
                             alt=""/>Simple to use and implement</td>
                    <td><img src="${resource(dir: 'images', file: 'check.png')}" height="16px"
                             alt=""/>Dashboard to manage your account</td>
                    <td><img src="${resource(dir: 'images', file: 'check.png')}" height="16px" alt=""/>Usage statistics
                    </td>
                </tr>
                <tr>
                    <td><img src="${resource(dir: 'images', file: 'check.png')}" height="16px"
                             alt=""/>Ability to see and analyze faulty data pushes</td>
                    <td><img src="${resource(dir: 'images', file: 'check.png')}" height="16px"
                             alt=""/>Multiple applications per account possible</td>
                    <td><img src="${resource(dir: 'images', file: 'check.png')}" height="16px"
                             alt=""/>Can be used in: E-Commerce sites, dating sites etc.</td>
                </tr>
            </table>
        </div>

        <div id="mainText">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" style="width:100%;height:100%">
                <tr>
                    <td valign="middle" style="vertical-align: middle;text-align: left" align="left">
                        <h3 style="margin:0;padding: 0;font-family: 'Istok Web'">Climb The Ladder Of Success...</h3>

                        <h3 style="margin: 0;padding: 0;font-family: 'Istok Web'">With Our...</h3>

                        <h1 style="font-size: 34px;margin-top: 5px">RECOMMENDATION API</h1>
                    </td>
                </tr>
            </table>
        </div>

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
                        <form id="loginFormActual" action="">
                            <input class="required" type="text" name="username" placeholder="Username"/><br/>
                            <input class="required" type="password" name="password" placeholder="Password"/><br/>
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
                        <form id="registerFormActual" action="">
                            <input class="required" type="text" name="firstName" placeholder="First Name"/><br/>
                            <input class="required" type="text" name="lastName" placeholder="Last Name"/><br/>
                            <input class="required email" type="text" name="email" placeholder="Email"/><br/>
                            <button type="submit">Register</button>
                        </form>
                    </td>
                </tr>
            </table>
        </div>
        <script type="text/javascript">
            window.loginFormHtml = jQuery("#loginForm").html();
            window.aboutPageHTML = jQuery("#aboutPage").html();
            window.apiDocHTML = jQuery("#apiDoc").html();
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
            });
            $("#docsNavItem").live('click', function () {
                TINY.box.show({
                    html:window.apiDocHTML,
                    animate:true,
                    close:true,
                    openjs:function () {
                    }
                });
            });
            $("#aboutNavItem").live('click', function () {
                TINY.box.show({
                    html:window.aboutPageHTML,
                    animate:true,
                    close:true,
                    openjs:function () {
                    }
                });
            });
        </script>
    </body>
</html>
