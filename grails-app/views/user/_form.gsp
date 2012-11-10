<%@ page import="com.recommender.domain.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'applications', 'error')} ">
    <label for="applications">
        <g:message code="user.applications.label" default="Applications"/>

    </label>

    <ul>
        <g:each in="${userInstance?.applications ?}" var="a">
            <li><g:link controller="application" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
        </g:each>
    </ul>
    <g:link controller="application" action="create"
            params="['user.id': userInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'application.label', default: 'Application')])}</g:link>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} ">
    <label for="email">
        <g:message code="user.email.label" default="Email"/>

    </label>
    <g:textField name="email" value="${userInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
    <label for="enabled">
        <g:message code="user.enabled.label" default="Enabled"/>

    </label>
    <g:checkBox name="enabled" value="${userInstance?.enabled}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'firstName', 'error')} ">
    <label for="firstName">
        <g:message code="user.firstName.label" default="First Name"/>

    </label>
    <g:textField name="firstName" value="${userInstance?.firstName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'lastName', 'error')} ">
    <label for="lastName">
        <g:message code="user.lastName.label" default="Last Name"/>

    </label>
    <g:textField name="lastName" value="${userInstance?.lastName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} ">
    <label for="password">
        <g:message code="user.password.label" default="Password"/>

    </label>
    <g:textField name="password" value="${userInstance?.password}"/>
</div>

