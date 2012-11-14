<div class="PostContent" id="content">
<%-- End of template part --%>

<openmrs:forEachAlert>
<c:if test="${varStatus.first}"><div id="alertOuterBox"><div id="alertInnerBox"></c:if>
<div class="alert">
<a href="#markRead" onClick="return markAlertRead(this, '${alert.alertId}')" HIDEFOCUS class="markAlertRead">
<img src="${pageContext.request.contextPath}/images/markRead.gif" alt='<spring:message code="Alert.mark"/>' title='<spring:message code="Alert.mark"/>'/> <span class="markAlertText"><spring:message code="Alert.markAsRead"/></span>
</a>
${alert.text} ${alert.dateToExpire} <c:if test="${alert.satisfiedByAny}"><i class="smallMessage">(<spring:message code="Alert.mark.satisfiedByAny"/>)</i></c:if>
</div>

<c:if test="${varStatus.last}">
<div id="alertBar">
<img src="${pageContext.request.contextPath}/images/alert.gif" align="center" alt='<spring:message code="Alert.unreadAlert"/>' title='<spring:message code="Alert.unreadAlert"/>'/>
<c:if test="${varStatus.count == 1}"><spring:message code="Alert.unreadAlert"/></c:if>
<c:if test="${varStatus.count != 1}"><spring:message code="Alert.unreadAlerts" arguments="${varStatus.count}" /></c:if>
</div>
</c:if>
</openmrs:forEachAlert>

<c:if test="${msg != null}"><div class="openmrs_msg"><spring:message code="${msg}" text="${msg}" arguments="${msgArgs}" /></div></c:if>
<c:if test="${err != null}"><div class="openmrs_error"><spring:message code="${err}" text="${err}" arguments="${errArgs}"/></div></c:if>
<div id="openmrs_dwr_error" style="display:none" class="error">
<div id="openmrs_dwr_error_msg"></div>
<div id="openmrs_dwr_error_close" class="smallMessage">
<i><spring:message code="error.dwr.stacktrace"/></i> 
<a href="#" onclick="this.parentNode.parentNode.style.display='none'"><spring:message code="error.dwr.hide"/></a>
</div>
</div>

