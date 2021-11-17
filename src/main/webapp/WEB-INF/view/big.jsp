<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<head>

    <jsp:include page="fragments/headerTags.jsp"/>

    <style>
/*
        .indicator {
            background-color: yellow;
        }
*/

        .left-team {
            background-color: #89ec9e;
        }

        .right-team {
            background-color: #eaa078;
        }
    </style>
    <script>
        var team;
        var leftTeamName;
        var rightTeamName;
        var leftTeamScore;
        var rightTeamScore;

        var accumScore = 0;
        var accumScoreDisplay;

        var bigGame1;
        var bigGame2;
        var bigGame3;
        var bigGame4;
        var bigGame5;
        var bigGame6;

        $(document).ready(function() {
            leftTeamName = document.getElementById("leftTeamName");
            rightTeamName = document.getElementById("rightTeamName");
            leftTeamScore = document.getElementById("leftTeamScore");
            rightTeamScore = document.getElementById("rightTeamScore");
            accumScoreDisplay = document.getElementById("accumScoreDisplay");
            accumScoreDisplay.innerHTML = accumScore;

            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/getTeam",
                data: $('#teams').serialize(),
                success: function (data, textStatus) {
                    updateTeamAtJsp(data);
                }
            });

            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/bigGameStages",
                // data: $('#teams').serialize(),
                success: function (data, textStatus) {
                    bigGameSetting(data);
                }
            });

            $(".btn").click(function () {
                if($(this).attr("id") == "timer-button") {
                    timer();
                    return;
                }
                if($(this).attr("id") == "timer-reset") {
                    reset();
                    return;
                }

                var id = $(this).attr("id").split("-");
                var thisGame = window["bigGame" + id[1]];
                if (id[0] == "q") {
                    $(this).removeClass("btn-secondary");
                    $(this).addClass("btn-dark");
                    // $(this).attr("disabled", true);
                    $(this).html("<div class=\"row\"> <div class=\"col text-left pl-4 text-nowrap\"> " + thisGame.stageQuestion.toUpperCase() + " </div></div>");
                } else if (id[0] == "a") {
                    var answer;
                    var score;
                    document.getElementById('line_open_sound').play();
                    switch (id[2]) {
                        case "1" :
                            answer = thisGame.firstAnswer;
                            score = thisGame.firstScore;
                            break;
                        case "2" :
                            answer = thisGame.secondAnswer;
                            score = thisGame.secondScore;
                            break;
                        case "3" :
                            answer = thisGame.thirdAnswer;
                            score = thisGame.thirdScore;
                            break;
                        case "4" :
                            answer = thisGame.fourthAnswer;
                            score = thisGame.fourthScore;
                            break;
                        case "5" :
                            answer = thisGame.fifthAnswer;
                            score = thisGame.fifthScore;
                            break;
                        case "6" :
                            answer = thisGame.sixthAnswer;
                            score = thisGame.sixthScore;
                            break;
                    }
                    accumScore += score;
                    accumScoreDisplay.innerHTML = accumScore;
                    $(this).removeClass("btn-primary");
                    $(this).addClass("btn-outline-primary");
                    $(this).attr("disabled", true);
                    $(this).html("<div class=\"row\"> <div class=\"col text-left pl-4 text-nowrap\"> " + answer.toUpperCase() + " </div> <div class=\"col text-right pr-4 font-weight-bold\"> " + score + " </div> </div>");
                }
            });

            $(document).keypress(function (event) {
                var code = event.keyCode;
                if (event.keyCode === 122) { // 122 code - "z" key, "en" keyboard, low register
                    document.getElementById('fault_sound').play();
                }
                if (event.keyCode === 102) { // 102 code - "f" key, "en" keyboard, low register
                    document.getElementById('intro_sound').play();
                    $('#introModal').modal('show');
                }
            });


            $('#left-team-score-write').click(function () {
                team.leftScore += accumScore;
                afterScoreSaving();
            });

            $('#right-team-score-write').click(function () {
                team.rightScore += accumScore;
                afterScoreSaving();
            });

        });

        function reset() {
            document.getElementById("timer-display").innerHTML = "0:20";

            $(".btn").each(function () {
                let id = $(this).attr("id").split("-");
                if(id.length > 1 && id[0] === 'q') {
                    $(this).removeClass("btn-dark");
                    $(this).addClass("btn-secondary");
                    // $(this).attr("disabled", true);
                    $(this).html("Вопрос " + id[1]);
                }
                if(id.length > 2 && id[0] === 'a') {
                    $(this).removeClass("btn-outline-primary");
                    $(this).addClass("btn-primary");
                    $(this).attr("disabled", false);
                    $(this).html(id[2]);
                }
            })
        }

        // let isTimerRunning = false;

        function timer() {
            document.getElementById('timer_sound').play();
            $('#timer-button').attr("disabled", true);
            $('#timer-reset').attr("disabled", true);
            let timeRemain = 20;
            countdown();
            function countdown() {
                let displaySec = timeRemain < 10 ? "0" + timeRemain : timeRemain;
                document.getElementById("timer-display").innerHTML = "0:" + displaySec;
                timeRemain--;
                if(timeRemain >= 0) {
                    setTimeout(countdown, 1000);
                    }
                }
                setTimeout(setTimerEnabled, 20000)
                function setTimerEnabled() {
                    $('#timer-button').attr("disabled", false);
                    $('#timer-reset').attr("disabled", false);
                }
            // }
        }

        function afterScoreSaving() {
            accumScore = 0;
            accumScoreDisplay.innerHTML = accumScore;
            updateTeamAtServer();
            document.getElementById('win').play();
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

        function bigGameSetting(bigGames) {
            bigGame1 = bigGames[0];
            bigGame2 = bigGames[1];
            bigGame3 = bigGames[2];
            bigGame4 = bigGames[3];
            bigGame5 = bigGames[4];
            bigGame6 = bigGames[5];
        }

        function updateTeamAtJsp(data) {
            team = data;
            leftTeamName.innerHTML = team.leftName;
            rightTeamName.innerHTML = team.rightName;
            leftTeamScore.innerHTML = team.leftScore;
            rightTeamScore.innerHTML = team.rightScore;
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

    <div class="container">
        <div class="row mt-4 mb-4">
            <div class="col pt-1 pb-1 text-center border" id="bigGameIndicator">
                <h2>Большая игра</h2>
            </div>
        </div>
        <div class="row mb-3">
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

        <div class="row mt-3 mb-3 text-center">
            <div class="col-1 text-left pl-0">
                <button type="button" id="left-team-score-write" class="btn btn-outline-dark left-team">
                    <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-shift-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M7.27 2.047a1 1 0 0 1 1.46 0l6.345 6.77c.6.638.146 1.683-.73 1.683H11.5v3a1 1 0 0 1-1 1h-5a1 1 0 0 1-1-1v-3H1.654C.78 10.5.326 9.455.924 8.816L7.27 2.047z"/>
                    </svg>
                </button>
            </div>
            <div class="col"></div>
            <div class="col-1 text-center pr-0">
                <button class="btn btn-outline-danger" id="timer-button">Таймер</button>
            </div>
            <div class="col-1 text-center">
                <h3 id="timer-display">0:20</h3>
            </div>
            <div class="col-1 text-center pl-0">
                <button class="btn btn-outline-success" id="timer-reset">Сброс</button>
            </div>
            <div class="col"></div>
            <div class="col-1 text-right pr-0">
                <button type="button" id="right-team-score-write" class="btn btn-outline-dark right-team">
                    <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-shift-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M7.27 2.047a1 1 0 0 1 1.46 0l6.345 6.77c.6.638.146 1.683-.73 1.683H11.5v3a1 1 0 0 1-1 1h-5a1 1 0 0 1-1-1v-3H1.654C.78 10.5.326 9.455.924 8.816L7.27 2.047z"/>
                    </svg>
                </button>
            </div>
        </div>

        <div class="row p-0 mt-3">
            <div class="col text-center pl-0">
                <button type="button" id="q-1" class="btn btn-secondary btn-sm btn-block mt-1">
                    Вопрос 1
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="q-2" class="btn btn-secondary btn-sm btn-block mt-1">
                    Вопрос 2
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="q-3" class="btn btn-secondary btn-sm btn-block mt-1">
                    Вопрос 3
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-1-1" class="btn btn-primary btn-sm btn-block mt-1">
                    1
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-2-1" class="btn btn-primary btn-sm btn-block mt-1">
                    1
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-3-1" class="btn btn-primary btn-sm btn-block mt-1">
                    1
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-1-2" class="btn btn-primary btn-sm btn-block mt-1">
                    2
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-2-2" class="btn btn-primary btn-sm btn-block mt-1">
                    2
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-3-2" class="btn btn-primary btn-sm btn-block mt-1">
                    2
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-1-3" class="btn btn-primary btn-sm btn-block mt-1">
                    3
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-2-3" class="btn btn-primary btn-sm btn-block mt-1">
                    3
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-3-3" class="btn btn-primary btn-sm btn-block mt-1">
                    3
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-1-4" class="btn btn-primary btn-sm btn-block mt-1">
                    4
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-2-4" class="btn btn-primary btn-sm btn-block mt-1">
                    4
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-3-4" class="btn btn-primary btn-sm btn-block mt-1">
                    4
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-1-5" class="btn btn-primary btn-sm btn-block mt-1">
                    5
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-2-5" class="btn btn-primary btn-sm btn-block mt-1">
                    5
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-3-5" class="btn btn-primary btn-sm btn-block mt-1">
                    5
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-1-6" class="btn btn-primary btn-sm btn-block mt-1">
                    6
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-2-6" class="btn btn-primary btn-sm btn-block mt-1">
                    6
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-3-6" class="btn btn-primary btn-sm btn-block mt-1">
                    6
                </button>
            </div>
        </div>

        <div class="row p-0 mt-3">
            <div class="col text-center pl-0">
                <button type="button" id="q-4" class="btn btn-secondary btn-sm btn-block mt-1">
                    Вопрос 4
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="q-5" class="btn btn-secondary btn-sm btn-block mt-1">
                    Вопрос 5
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="q-6" class="btn btn-secondary btn-sm btn-block mt-1">
                    Вопрос 6
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-4-1" class="btn btn-primary btn-sm btn-block mt-1">
                    1
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-5-1" class="btn btn-primary btn-sm btn-block mt-1">
                    1
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-6-1" class="btn btn-primary btn-sm btn-block mt-1">
                    1
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-4-2" class="btn btn-primary btn-sm btn-block mt-1">
                    2
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-5-2" class="btn btn-primary btn-sm btn-block mt-1">
                    2
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-6-2" class="btn btn-primary btn-sm btn-block mt-1">
                    2
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-4-3" class="btn btn-primary btn-sm btn-block mt-1">
                    3
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-5-3" class="btn btn-primary btn-sm btn-block mt-1">
                    3
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-6-3" class="btn btn-primary btn-sm btn-block mt-1">
                    3
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-4-4" class="btn btn-primary btn-sm btn-block mt-1">
                    4
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-5-4" class="btn btn-primary btn-sm btn-block mt-1">
                    4
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-6-4" class="btn btn-primary btn-sm btn-block mt-1">
                    4
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-4-5" class="btn btn-primary btn-sm btn-block mt-1">
                    5
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-5-5" class="btn btn-primary btn-sm btn-block mt-1">
                    5
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-6-5" class="btn btn-primary btn-sm btn-block mt-1">
                    5
                </button>
            </div>
        </div>
        <div class="row p-0">
            <div class="col text-center pl-0">
                <button type="button" id="a-4-6" class="btn btn-primary btn-sm btn-block mt-1">
                    6
                </button>
            </div>
            <div class="col text-center">
                <button type="button" id="a-5-6" class="btn btn-primary btn-sm btn-block mt-1">
                    6
                </button>
            </div>
            <div class="col text-center pr-0">
                <button type="button" id="a-6-6" class="btn btn-primary btn-sm btn-block mt-1">
                    6
                </button>
            </div>
        </div>



    </div>


</body>