<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<head>
    <jsp:include page="fragments/headerTags.jsp"/>
    <script>
        $(document).ready(function() {
            $(".btn-q").click(function () {

            });
        });
    </script>
    <style>

        body {
            background-image: url(./resources/images/background.jpg);
            background-size: cover;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row mt-5 mb-5">

        </div>
        <div class="row">
            <div class="col"></div>
            <div class="col"></div>

            <div class="col">
                <a href="${pageContext.request.contextPath}/game100">
                    <div class="card">
                        <img class="card-img" src="./resources/images/intro_pic.jpeg" alt="...">
                    </div>
                </a>
            </div>
            <div class="col">
                <a href="${pageContext.request.contextPath}/soundRow">
                    <div class="card">
                        <img class="card-img" src="./resources/images/sound_row.jpg" alt="...">
                    </div>
                </a>
            </div>

        </div>
    </div>
</body>