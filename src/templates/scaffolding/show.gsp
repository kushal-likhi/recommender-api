<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h2><g:message code="default.show.label" args="[entityName]"/></h2>
        <ul>
            <li><g:link class="create" action="create">Add ${className}</g:link></li>
        </ul>
    </div>

    <div class="block_content">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tbody>
            <% excludedProps = Event.allEvents.toList() << 'version' << 'password' << 'dateCreated' << 'lastUpdated' << 'id'
            allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
            props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
            props.each { p -> %>
            <tr class="prop">
                <td valign="top" class="name"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}"/></td>
                <% if (p.isEnum()) { %>
                <td valign="top" class="value">\${${propertyName}?.${p.name}?.encodeAsHTML()}</td>
                <% } else if (p.oneToMany || p.manyToMany) { %>
                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                            <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show"
                                        id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>
                <% } else if (p.manyToOne || p.oneToOne) { %>
                <td valign="top" class="value"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show"
                                                       id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></td>
                <% } else if (p.type == Boolean.class || p.type == boolean.class) { %>
                <td valign="top" class="value"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}"/></td>
                <% } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                <td valign="top" class="value"><g:formatDate date="\${${propertyName}?.${p.name}}"/></td>
                <% } else if (!p.type.isArray()) { %>
                <td valign="top" class="value">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                <% } %>
            </tr>
            <% } %>
            </tbody>
        </table>

        <div class="buttons">
            <p>
                <g:form>
                    <g:hiddenField name="id" value="\${${propertyName}?.id}"/>
                    <span class="button"><g:actionSubmit class="submit small" action="edit" value="\${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
                    <span class="button"><g:actionSubmit class="submit small" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                         onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                </g:form>
            </p>
        </div>
    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>

</div>
</body>
</html>
