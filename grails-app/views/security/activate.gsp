<%--
  Created by IntelliJ IDEA.
  User: kushal
  Date: 10/11/12
  Time: 1:38 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta content="mainSite" name="layout">
        <title></title>
    </head>

    <body>
        <div id="mainBox">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" style="width:100%;height:100%">
                <tr>
                    <td valign="middle" style="vertical-align: middle;text-align: left" align="left">
                        <h3 style="margin:0;padding: 0;font-family: 'Istok Web'">Congratulations! Your account has been activated...</h3>

                        <h3 style="margin: 0;padding: 0;font-family: 'Istok Web'">Just one last step...</h3>

                        <h2 style="font-size: 34px;margin-top: 5px">Please Set Your Password</h2>

                        <p>

                        <form id="spff" action="${createLink(controller: 'security', action: 'activationComplete')}"
                              method="POST">
                            <input class="required" type="password" placeholder="Password" name="password"
                                   id="password"/><br/>
                            <input class="required" type="password" placeholder="Confirm Password"
                                   name="ConfirmPassword"/><br/>
                            <input type="hidden" name="userId" value="${id.toString()}"/>
                            <input type="hidden" name="token" value="${token}"/>
                            <button style="margin-left: 5px" type="submit">Proceed</button>
                        </form>
                    </p>
                    </td>
                </tr>
            </table>
            <script type="text/javascript">
                $("#spff").validate({
                    rules:{
                        password:{
                            required:true,
                            minlength:5
                        },
                        ConfirmPassword:{
                            required:true,
                            minlength:5,
                            equalTo:"#password"
                        }
                    },
                    messages:{
                        password:{
                            required:"Please provide a password",
                            minlength:"Your password must be at least 5 characters long"
                        },
                        ConfirmPassword:{
                            required:"Please provide a password",
                            minlength:"Your password must be at least 5 characters long",
                            equalTo:"Please enter the same password as above"
                        }
                    }
                });
            </script>
        </div>
    </body>
</html>