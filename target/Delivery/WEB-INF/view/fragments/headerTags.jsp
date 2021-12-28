<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <%--Csfr token--%>
<%--    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>--%>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/datatables/1.10.21/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap4-glyphicons/css/bootstrap-glyphicons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/datetimepicker/2.5.20/jquery.datetimepicker.css">
    <script src="${pageContext.request.contextPath}/webjars/jquery/3.5.1/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/webjars/jquery/3.5.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/webjars/datatables/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/webjars/datatables/1.10.21/js/dataTables.bootstrap4.min.js"></script>
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootbox.min.js"></script>

    <audio id="intro_sound" src="${pageContext.request.contextPath}/resources/sounds/Intro.mp3"></audio>
    <audio id="line_open_sound" src="${pageContext.request.contextPath}/resources/sounds/line_open.mp3"></audio>
    <audio id="fault_sound" src="${pageContext.request.contextPath}/resources/sounds/Mistake.mp3"></audio>
    <audio id="SimpleGame_sound" src="${pageContext.request.contextPath}/resources/sounds/SimpleGame.mp3"></audio>
    <audio id="timer_sound" src="${pageContext.request.contextPath}/resources/sounds/timer.mp3"></audio>
    <audio id="score_enroll" src="${pageContext.request.contextPath}/resources/sounds/score_enroll.mp3"></audio>
    <audio id="coins" src="${pageContext.request.contextPath}/resources/sounds/coins.mp3"></audio>
    <audio id="win" src="${pageContext.request.contextPath}/resources/sounds/cash.mp3"></audio>


<%--    <link rel="shortcut icon" href="#" />--%>
<%--    <link rel="icon" href="data:,">--%>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" type="image/x-icon">

    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico" />


    <link rel="shortcut icon" href='<c:url value="/resources/images/favicon.ico" />' type="image/x-icon">
    <link rel="icon" href='<c:url value="/resources/images/favicon.ico" />' type="image/x-icon">

    <link href="/favicon.ico" rel="icon" type="image/x-icon">
<%--    <script src="${pageContext.request.contextPath}/resources/js/moment.js"></script>--%>
<%--    <script src="${pageContext.request.contextPath}/resources/js/generalScripts.js"></script>--%>



</head>