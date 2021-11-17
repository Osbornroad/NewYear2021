<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

    <head>
        <jsp:include page="fragments/headerTags.jsp"/>

        <style>
            .indicator {
                background-color: yellow;
            }

            .left-team {
                background-color: #89ec9e;
            }

            .right-team {
                background-color: #eaa078;
            }
        </style>

        <script>

/*            $(document).ready(function() {

                $('#sendTeamNames').modal('show');
            });*/

            var team;
            var leftTeamName;
            var rightTeamName;
            var leftTeamScore;
            var rightTeamScore;
            var leftTeamNameModal;
            var rightTeamNameModal;
            var accumScoreDisplay;

            var currentScore = 0;
            var stageMultiplier = 0;
            var accumScore = 0;

            $(document).ready(function() {

                $('#introModal').on('click', function () {
                    document.getElementById('intro_sound').play();
                    $('#intro_sound').on('ended', function () {
                        $('#introModal').modal('hide');
                    })
                });

                $('#introModal').modal('show');

                leftTeamName = document.getElementById("leftTeamName");
                rightTeamName = document.getElementById("rightTeamName");
                leftTeamScore = document.getElementById("leftTeamScore");
                rightTeamScore = document.getElementById("rightTeamScore");
                leftTeamNameModal = document.getElementById("leftTeamNameModal");
                rightTeamNameModal = document.getElementById("rightTeamNameModal");
                accumScoreDisplay = document.getElementById("accumScoreDisplay");
                accumScoreDisplay.innerHTML = accumScore;

                $(".fault").click(function () {
                    if ( $(this).attr("aria-pressed") == "false")
                    document.getElementById('fault_sound').play();
                });

                $(".fault").each( function () {
                    $(this).attr("aria-pressed", "false");
                    $(this).removeClass("active");
                });

                $(".btn-q").each(function () {
                    $(this).html($(this).attr("id").slice(-1));
                });

                $(".btn-q").click(function () {
                    if(stage === '') {
                        alert("Этап не выбран");
                        return;
                    }
                    var id = $(this).attr("id");
                    $(this).removeClass("btn-primary");
                    $(this).addClass("btn-outline-dark");
                    $(this).attr("disabled", true);
                    document.getElementById('line_open_sound').play();

                    switch (id) {
                        case "button_1":
                            $(this).html("<div class=\"row\"> <div class=\"col text-left pl-4 text-nowrap\"> " + stage.firstAnswer.toUpperCase() + " </div> <div class=\"col text-right pr-4 font-weight-bold\"> " + stage.firstScore + " </div> </div>");
                            currentScore = stage.firstScore * stageMultiplier;
                            break;
                        case "button_2":
                            $(this).html("<div class=\"row\"> <div class=\"col text-left pl-4 text-nowrap\"> " + stage.secondAnswer.toUpperCase() + " </div> <div class=\"col text-right pr-4 font-weight-bold\"> " + stage.secondScore + " </div> </div>");
                            currentScore = stage.secondScore * stageMultiplier;
                            break;
                        case "button_3":
                            $(this).html("<div class=\"row\"> <div class=\"col text-left pl-4 text-nowrap\"> " + stage.thirdAnswer.toUpperCase() + " </div> <div class=\"col text-right pr-4 font-weight-bold\"> " + stage.thirdScore + " </div> </div>");
                            currentScore = stage.thirdScore * stageMultiplier;
                            break;
                        case "button_4":
                            $(this).html("<div class=\"row\"> <div class=\"col text-left pl-4 text-nowrap\"> " + stage.fourthAnswer.toUpperCase() + " </div> <div class=\"col text-right pr-4 font-weight-bold\"> " + stage.fourthScore + " </div> </div>");
                            currentScore = stage.fourthScore * stageMultiplier;
                            break;
                        case "button_5":
                            $(this).html("<div class=\"row\"> <div class=\"col text-left pl-4 text-nowrap\"> " + stage.fifthAnswer.toUpperCase() + " </div> <div class=\"col text-right pr-4 font-weight-bold\"> " + stage.fifthScore + " </div> </div>");
                            currentScore = stage.fifthScore * stageMultiplier;
                            break;
                        case "button_6":
                            $(this).html("<div class=\"row\"> <div class=\"col text-left pl-4 text-nowrap\"> " + stage.sixthAnswer.toUpperCase() + " </div> <div class=\"col text-right pr-4 font-weight-bold\"> " + stage.sixthScore + " </div> </div>");
                            currentScore = stage.sixthScore * stageMultiplier;
                            break;
                    }
                    if (currentStageNum == 1 || currentStageNum == 2 || currentStageNum == 3) {
                        accumScore += currentScore;
                        accumScoreDisplay.innerHTML = accumScore;
                    }
                });

             /*   function makeQuestionUnavailable() {
                    $(".btn-q").each(function () {
                        if ($(this).hasClass("btn-outline-dark")) {
                            $(this).attr("disabled", true);
                        }
                    });
                }*/

                $('#left-team-score-write').click(function () {
                    if (currentStageNum == 1 || currentStageNum == 2 || currentStageNum == 3) {
                        team.leftScore += accumScore;
                    } else if (currentStageNum == 4) {
                        team.leftScore += currentScore;
                    }
                    afterScoreSaving();
                });

                $('#right-team-score-write').click(function () {
                    if (currentStageNum == 1 || currentStageNum == 2 || currentStageNum == 3) {
                        team.rightScore += accumScore;
                    } else if (currentStageNum == 4) {
                        team.rightScore += currentScore;
                    }
                    afterScoreSaving();
                });

                $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/getTeam",
                    data: $('#teams').serialize(),
                    success: function (data, textStatus) {
                        updateTeamAtJsp(data);
                    }
                });

                $('#nextStageModal').click(function () {
                    $('#next-modal-content').html('');
                    $('#nextStageModal').modal('hide');
                    chooseGame();
                });
            });

            function afterScoreSaving() {
                accumScore = 0;
                accumScoreDisplay.innerHTML = accumScore;
                currentScore = 0;
                // makeQuestionUnavailable();
                updateTeamAtServer();
                document.getElementById('win').play();

            }

            function updateTeamAtJsp(data) {
                team = data;
                leftTeamName.innerHTML = team.leftName;
                rightTeamName.innerHTML = team.rightName;
                leftTeamScore.innerHTML = team.leftScore;
                rightTeamScore.innerHTML = team.rightScore;
            }

            function showModalTeamNames() {
                $('#sendTeamNames').modal('show');
            }

            function changeTeamNames() {
                $('#sendTeamNames').modal('hide');
                team.leftName = $('#leftTeamNameModal').val();
                team.rightName = $('#rightTeamNameModal').val();
                updateTeamAtServer();
            }

            function updateTeamAtServer() {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/updateTeam",
                    data: team,
                    success: function (data, textStatus) {
                        updateTeamAtJsp(data);
                    }
                });
            }

            var currentStageNum = 0;
            var stageNum = 1;
            var stage = '';

            function showNextStepModal() {
                document.getElementById('question').innerHTML = '';
                accumScore = 0;
                accumScoreDisplay.innerHTML = accumScore;
                $(".fault").each( function () {
                    $(this).attr("aria-pressed", "false");
                    $(this).removeClass("active");
                });
                $(".btn-q").each(function () {
                    $(this).removeClass("btn-outline-dark");
                    $(this).addClass("btn-primary");
                    $(this).attr("disabled", false);
                    $(this).html($(this).attr("id").slice(-1));
                });
                document.getElementById('SimpleGame_sound').play();
                switch (stageNum) {
                    case 1:
                        $('#next-modal-content').html("<img src=\"./resources/images/simple-g.jpeg\" class=\"img-fluid\" alt=\"Responsive image\">");
                        break;
                    case 2:
                        $('#next-modal-content').html("<img src=\"./resources/images/double-g.jpeg\" class=\"img-fluid\" alt=\"Responsive image\">");
                        break;
                    case 3:
                        $('#next-modal-content').html("<img src=\"./resources/images/triple-g.jpeg\" class=\"img-fluid\" alt=\"Responsive image\">");
                        break;
                    case 4:
                        $('#next-modal-content').html("<img src=\"./resources/images/reverse-g.jpeg\" class=\"img-fluid\" alt=\"Responsive image\">");
                        break;
                    case 5:
                        $('#next-modal-content').html("<img src=\"./resources/images/big-g.jpeg\" class=\"img-fluid\" alt=\"Responsive image\">");
                        break;
                }
                $('#nextStageModal').modal('show');
            }

            function chooseGame() {

                // var delayInMilliseconds = 3500;
                // setTimeout(function() {
                    switch (stageNum) {
                        case 1:
                            $('#simpleGameIndicator').addClass('indicator');
                            loadStage("simpleGame");
                            stageMultiplier = 1;
                            stageNum++;
                            break;
                        case 2:
                            $('#doubleGameIndicator').addClass('indicator');
                            $('#simpleGameIndicator').removeClass('indicator');
                            loadStage("doubleGame");
                            stageMultiplier = 2;
                            stageNum++;
                            break;
                        case 3:
                            $('#tripleGameIndicator').addClass('indicator');
                            $('#doubleGameIndicator').removeClass('indicator');
                            loadStage("tripleGame");
                            stageMultiplier = 3;
                            stageNum++;
                            break;
                        case 4:
                            $('#contraGameIndicator').addClass('indicator');
                            $('#tripleGameIndicator').removeClass('indicator');
                            document.getElementById('timer_sound').play();
                            loadStage("contraGame");
                            stageNum++;
                            stageMultiplier = 1;
                            break;
                        case 5:
                            stageMultiplier = 1;
                            <%--window.location.href = "${pageContext.request.contextPath}/big";--%>
                            goToBigGame();
                            break;
                            /*$('#bigGameIndicator').addClass('indicator');
                            $('#contraGameIndicator').removeClass('indicator');
                            loadStage("bigGame");
                            stageMultiplier = 1;
                            break;*/
                    }
                    currentStageNum++;
                // }, delayInMilliseconds);
            }

            function goToBigGame() {
                window.location.href = "${pageContext.request.contextPath}/big";
            }

            function loadStage(stageName) {

                $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/getStage/" + stageName,
                    // data: team,
                    success: function (data, textStatus) {
                        stage = data;
                        document.getElementById("question").innerHTML = stage.stageQuestion;
                    }
                });
            }
        </script>

    </head>

    <body>

        <div class="modal fade bd-example-modal-lg" id="introModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content" id="intro-modal-content">
                    <img src="./resources/images/intro_pic.jpeg" class="img-fluid" alt="Responsive image">
                </div>
            </div>
        </div>

        <div class="modal fade bd-example-modal-lg" id="nextStageModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content" id="next-modal-content">
<%--                    <img src="./resources/images/simple-g.jpeg" class="img-fluid" alt="Responsive image">--%>
                </div>
            </div>
        </div>

<%--        <img src="./resources/images/intro_pic.jpeg" class="img-fluid" alt="Responsive image">--%>

        <div class="container">
<%--            <button type="button" class="btn btn-outline-danger" onclick="goToBigGame()">Big game</button>--%>
            <div class="row mt-4 mb-4" onclick="showNextStepModal()">
                <div class="col pt-4 pb-4 text-center border" id="simpleGameIndicator">
                    <h5>Простая игра</h5>
                </div>
                <div class="col pt-4 pb-4 text-center border" id="doubleGameIndicator">
                    <h5>Двойная игра</h5>
                </div>
                <div class="col pt-4 pb-4 text-center border" id="tripleGameIndicator">
                    <h5>Тройная игра</h5>
                </div>
                <div class="col pt-4 pb-4 text-center border" id="contraGameIndicator">
                    <h5>Игра наоборот</h5>
                </div>
                <div class="col pt-4 pb-4 text-center border" id="bigGameIndicator">
                    <h5>Большая игра</h5>
                </div>
            </div>
            <div class="row mb-5 " onclick="showModalTeamNames()">
                <div class="col-1 pt-2 pb-2 text-center left-team">
                    <h3 class="" id="leftTeamScore"></h3>
                </div>
                <div class="col pt-2 pb-2 text-left left-team">
                    <h3 class="" id="leftTeamName"></h3>
                </div>
                <div class="col-1 pt-2 pb-2 text-center">
                    <h3 class="" id="accumScoreDisplay"></h3>
                </div>
                <div class="col pt-2 pb-2 text-right right-team">
                    <h3 class="" id="rightTeamName"></h3>
                </div>
                <div class="col-1 pt-2 pb-2 text-center right-team">
                    <h3 class="" id="rightTeamScore"></h3>
                </div>
            </div>

<%--            Stage--%>
            <div class="row mt-5 text-center">
                <div class="col-1 text-left pl-0">
                    <button type="button" id="left-team-score-write" class="btn btn-outline-dark left-team">
                        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-shift-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" d="M7.27 2.047a1 1 0 0 1 1.46 0l6.345 6.77c.6.638.146 1.683-.73 1.683H11.5v3a1 1 0 0 1-1 1h-5a1 1 0 0 1-1-1v-3H1.654C.78 10.5.326 9.455.924 8.816L7.27 2.047z"/>
                        </svg>
                    </button>
                </div>
                <div class="col">
                  <h3 class="text-center" id="question"></h3>
                </div>
                <div class="col-1 text-right pr-0">
                    <button type="button" id="right-team-score-write" class="btn btn-outline-dark right-team">
                        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-shift-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" d="M7.27 2.047a1 1 0 0 1 1.46 0l6.345 6.77c.6.638.146 1.683-.73 1.683H11.5v3a1 1 0 0 1-1 1h-5a1 1 0 0 1-1-1v-3H1.654C.78 10.5.326 9.455.924 8.816L7.27 2.047z"/>
                        </svg>
                    </button>
                </div>
            </div>

            <div class="row mt-5">
                <div class="col text-left pl-0">
                    <button type="button" id="buttonLeftAlert_1" class="btn btn-outline-danger btn-lg fault" data-toggle="button" aria-pressed="false">X</button>
                </div>
                <div class="col-6 text-center">
                    <button type="button" id="button_1" class="btn btn-primary btn-lg btn-block btn-q">

                    </button>
                </div>
                <div class="col text-right pr-0">
                    <button type="button" id="buttonRightAlert_1" class="btn btn-outline-danger btn-lg fault" data-toggle="button" aria-pressed="false">X</button>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col text-left pl-0">
                    <button type="button" id="buttonLeftAlert_2" class="btn btn-outline-danger btn-lg fault" data-toggle="button" aria-pressed="false">X</button>
                </div>
                <div class="col-6 text-center">
                    <button type="button" id="button_2" class="btn btn-primary btn-lg btn-block btn-q">

                    </button>
                </div>
                <div class="col text-right pr-0">
                    <button type="button" id="buttonRightAlert_2" class="btn btn-outline-danger btn-lg fault" data-toggle="button" aria-pressed="false">X</button>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col text-left pl-0">
                    <button type="button" id="buttonLeftAlert_3" class="btn btn-outline-danger btn-lg fault" data-toggle="button" aria-pressed="false">X</button>
                </div>
                <div class="col-6 text-center">
                    <button type="button" id="button_3" class="btn btn-primary btn-lg btn-block btn-q">

                    </button>
                </div>
                <div class="col text-right pr-0">
                    <button type="button" id="buttonRightAlert_3" class="btn btn-outline-danger btn-lg fault" data-toggle="button" aria-pressed="false">X</button>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col text-left">
                </div>
                <div class="col-6 text-center">
                    <button type="button" id="button_4" class="btn btn-primary btn-lg btn-block btn-q">

                    </button>
                </div>
                <div class="col text-right">
                </div>
            </div>
            <div class="row mt-4">
                <div class="col text-left">
                </div>
                <div class="col-6 text-center">
                    <button type="button" id="button_5" class="btn btn-primary btn-lg btn-block btn-q">

                    </button>
                </div>
                <div class="col text-right">
                </div>
            </div>
            <div class="row mt-4">
                <div class="col text-left">
                </div>
                <div class="col-6 text-center">
                    <button type="button" id="button_6" class="btn btn-primary btn-lg btn-block btn-q">

                    </button>
                </div>
                <div class="col text-right">
                </div>
            </div>
        </div>

    </body>

<div class="modal fade" role="dialog" id="sendTeamNames" tabindex = "-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="modalTitle">Введите названия команд</h2>
<%--                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--%>
            </div>
            <div class="modal-body">
                <sf:form class="form-vertical" id="teams">
                    <div class="form-group" >
                        <div class="row">
                            <div class="col">
                                <label class="control-label col-sm-3" for="leftTeamNameModal">Команда слева</label>
                                <div>
                                    <input class="form-control" name="leftTeamNameModal" id="leftTeamNameModal">
                                </div>
                            </div>
                            <div class="col">
                                <label class="control-label col-sm-3" for="rightTeamNameModal">Команда справа</label>
                                <div>
                                    <input class="form-control" name="rightTeamNameModal" id="rightTeamNameModal">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <button class="btn btn-primary float-right" onclick="changeTeamNames()" type="button">
                            <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                        </button>
                    </div>
                </sf:form>
                <%--<div class="col">
                    <a class="btn btn-danger" type="button" onclick="clearFilter()">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                    </a>
                    <a class="btn btn-primary" type="button" onclick="updateTable()">
                        <span class="glyphicon glyphicon-filter" aria-hidden="true"></span>
                    </a>
                </div>--%>
            </div>
        </div>
    </div>
</div>
