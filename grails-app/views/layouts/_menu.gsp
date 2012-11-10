<div id="header">
    <div class="hdrl"></div>

    <div class="hdrr"></div>

    <h1>&nbsp;</h1>
    <ul id="nav">
        <li>
            <g:link controller="application" action="Stats">Stats</g:link>
        </li>
        <li>
            <g:link controller="application" action="list">Applications</g:link>
        </li>
        <li>
            <g:link controller="application" action="create">Create New App</g:link>
        </li>

        <g:isAdmin>
            <li><a href="#">Admin</a>
                <ul>
                    <li><g:link controller="user" action="list">Users</g:link></li>
                </ul>
            </li>
        </g:isAdmin>
    </ul>
</div>