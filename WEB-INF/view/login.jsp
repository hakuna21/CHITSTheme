<%@ include file="/WEB-INF/template/include.jsp" %>

<spring:message var="pageTitle" code="login.title" scope="page"/>
<%@ include file="/WEB-INF/template/header.jsp" %>

<center>
<br/><br/><br/>
<openmrs:portlet url="welcome" parameters="showName=true|showLogin=true" />
</center>

<%@ include file="/WEB-INF/template/footer.jsp" %>
