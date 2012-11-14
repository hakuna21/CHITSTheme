<%-- This is the CHITS banner.jsp --%>
<div id="banner">
<a href="<spring:theme code="url.organization" />"><div id="logosmall"><img src="<%= request.getContextPath() %><spring:theme code="image.logo.text.small" />" alt="OpenMRS Logo" border="0"/></div></a>  
<table id="bannerbar"><tr>
<td id="logocell"> <img src="<%= request.getContextPath() %><spring:theme code="image.logo.small" />" alt="" class="logo-reduced61" /></td><td id="barcell">
<div class="barsmall"><img align="left" src="<%= request.getContextPath() %><spring:theme code="image.logo.bar" />" alt="" class="bar-round-reduced50"/></div></td>
</tr></table>
</div>

<style>
#leftNav { display: block; position: static; top: 0; left: 0; width: 200px; padding-top: 100px; height: 100%; border: 1px solid red; }
#leftNav .navList { display: block; text-align: left; margin-left: 0em; padding: 0px; }
#leftNav ul.navList li { padding: 0px; margin: 0px; margin-bottom: 2em; margin-top: 2em; }
#leftNav ul.navList li a { color: black; margin: 2em; margin-left: 2em; border: 1px solid green; }
</style>

<openmrs:hasPrivilege privilege="View Navigation Menu">
<div id="leftNav">
<%@ include file="/WEB-INF/template/gutter.jsp" %>
</div>
</openmrs:hasPrivilege>
