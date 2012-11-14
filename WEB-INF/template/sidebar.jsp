<%-- Side bar --%>
<div class="sidebar1">
<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="${pageContext.request.contextPath}/index.htm">Home</a></li></ul></div>
</div></div></div>

<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="${pageContext.request.contextPath}/module/chits/patients/findPatient.htm">Patient Records</a></li></ul></div>
</div></div></div>

<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="${pageContext.request.contextPath}/module/chits/familyfolders/foldersList.htm" onclick="return true">Family Folders</a></li></ul></div>
</div></div></div>

<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="#" onclick="notImplemented()">Laboratory Schedule</a></li></ul></div>
</div></div></div>

<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="#" onclick="notImplemented()">Calendar</a></li></ul></div>
</div></div></div>

<openmrs:hasPrivilege privilege="View Administration Functions">
<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="${pageContext.request.contextPath}/module/chits/reports/queries.htm">Queries</a></li></ul></div>
</div></div></div>
</openmrs:hasPrivilege>

<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="#" onclick="notImplemented()">Stats</a></li></ul></div>
</div></div></div>

<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="#" onclick="notImplemented()">Alert Indicator</a></li></ul></div>
</div></div></div>

<openmrs:hasPrivilege privilege="View Administration Functions">
<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="${pageContext.request.contextPath}/admin/users/role.list">Manage User Types</a></li></ul></div>
</div></div></div>

<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="${pageContext.request.contextPath}/admin/users/users.list">Manage Users</a></li></ul></div>
</div></div></div>

<%--
<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="${pageContext.request.contextPath}/module/chits/admin/audit/loggedInUsers.list?showOnlyLoggedInUsers=true">View User Sessions</a></li></ul></div>
</div></div></div>
--%>

<div class="Block"><div class="Block-body"><div class="BlockContent">
<div class="BlockContent-tl"></div><div class="BlockContent-tr"><div></div></div><div class="BlockContent-bl"><div></div></div><div class="BlockContent-br"><div></div></div><div class="BlockContent-tc"><div></div></div><div class="BlockContent-bc"><div></div></div><div class="BlockContent-cl"><div></div></div><div class="BlockContent-cr"><div></div></div><div class="BlockContent-cc"></div>
<div class="BlockContent-body"><ul><li><a href="${pageContext.request.contextPath}/admin"><spring:message code="Navigation.administration"/></a></li></ul></div>
</div></div></div>
</openmrs:hasPrivilege>

<div class="Block" id="chits-nthc"><div class="Block-body"><div class="BlockContent">
National Telehealth Center<br/>
University of the Philippines - Manila<br/>
${GlobalProperty['chits.nthc.telephone']}<br/>
</div></div></div>
</div>
<%-- End of Side bar --%>