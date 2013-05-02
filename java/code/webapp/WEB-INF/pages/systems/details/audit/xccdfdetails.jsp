<%@ taglib uri="http://rhn.redhat.com/rhn" prefix="rhn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://rhn.redhat.com/tags/list" prefix="rl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html:xhtml/>
<html>

<body>

<%@ include file="/WEB-INF/pages/common/fragments/systems/system-header.jspf" %>

<div class="toolbar">
  <c:choose>
    <c:when test="${not empty testResult.comparableId}">
      <a href="/rhn/audit/scap/DiffSubmit.do?first=${testResult.comparableId}&second=${testResult.id}&view=changed">
        <img src="/img/rhn-listicon-${testResult.diffIcon}.gif"
          alt="<bean:message key="scapdiff.jsp.i.${testResult.diffIcon}"/>"
          title="<bean:message key="scapdiff.jsp.i.${testResult.diffIcon}"/>"/>
        <bean:message key="system.audit.xccdfdetails.jsp.diff"/>
      </a>
    </c:when>
    <c:otherwise>
      <bean:message key="system.audit.xccdfdetails.jsp.nodiff"/>
    </c:otherwise>
  </c:choose>
  |

  <a href="/rhn/systems/details/audit/ScheduleXccdf.do?sid=${param.sid}&path=${testResult.scapActionDetails.path}&params=${testResult.scapActionDetails.parametersContents}">
    <img src="/img/restart.png" alt="<bean:message key="system.audit.xccdfdetails.jsp.reschedule"/>"/>
    <bean:message key="system.audit.xccdfdetails.jsp.reschedule"/>
  </a>
</div>

<h2><bean:message key="system.audit.xccdfdetails.jsp.header"/></h2>
<rhn:csrf/>

<table class="details">
  <tr>
    <th><bean:message key="system.audit.xccdfdetails.jsp.path"/>:</th>
    <td><c:out value="${testResult.scapActionDetails.path}"/></td>
  </tr>
  <tr>
    <th><bean:message key="system.audit.schedulexccdf.jsp.arguments"/>:</th>
    <td><c:out value="${testResult.scapActionDetails.parametersContents}"/></td>
  </tr>
  <tr>
    <th><bean:message key="configoverview.jsp.scheduledBy"/>:</th>
    <td>
      <img src="/img/rhn-listicon-user.gif" alt="<bean:message key="yourrhn.jsp.user.alt" />"/>
      <a href="/network/systems/details/history/event.pxt?sid=${param.sid}&hid=${testResult.scapActionDetails.parentAction.id}">
        <c:out value="${testResult.scapActionDetails.parentAction.schedulerUser.login}"/>
      </a>
    </td>
  </tr>
  <tr>
    <th><bean:message key="system.audit.xccdfdetails.jsp.benchmarkid"/>:</th>
    <td><c:out value="${testResult.benchmark.identifier}"/></td>
  </tr>
  <tr>
    <th><bean:message key="system.audit.xccdfdetails.jsp.version"/>:</th>
    <td><c:out value="${testResult.benchmark.version}"/></td>
  </tr>
  <tr>
    <th><bean:message key="system.audit.xccdfdetails.jsp.profileid"/>:</th>
    <td><c:out value="${testResult.profile.identifier}"/></td>
  </tr>
  <tr>
    <th><bean:message key="system.audit.xccdfdetails.jsp.title"/>:</th>
    <td><c:out value="${testResult.profile.title}"/></td>
  </tr>
  <tr>
    <th><bean:message key="system.audit.xccdfdetails.jsp.started"/>:</th>
    <td><c:out value="${testResult.startTime}"/></td>
  </tr>
  <tr>
    <th><bean:message key="system.audit.xccdfdetails.jsp.completed"/>:</th>
    <td><c:out value="${testResult.endTime}"/></td>
  </tr>
  <tr>
    <th><bean:message key="system.audit.xccdfdetails.jsp.errors"/>:</th>
    <td><pre><c:out value="${testResult.errrosContents}"/></pre></th>
</table>

<h2><bean:message key="system.audit.xccdfdetails.jsp.xccdfrules"/></h2>

<rl:listset name="xccdfDetails">
  <rhn:csrf/>
  <rl:list>
    <rl:decorator name="PageSizeDecorator"/>

    <%@ include file="/WEB-INF/pages/common/fragments/audit/rule-common-columns.jspf" %>

  </rl:list>
  <rl:csv name="xccdfDetails"
    exportColumns="id,documentIdref,identsString,evaluationResult"/>
</rl:listset>

</body>
</html>
