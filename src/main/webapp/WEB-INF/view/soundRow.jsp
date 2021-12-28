<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<head>
    <jsp:include page="fragments/headerTags.jsp"/>

    <audio id="stopwatch" src="${pageContext.request.contextPath}/resources/sounds/stopwatch.mp3"></audio>

    <audio id="timerEnd" src="${pageContext.request.contextPath}/resources/sounds/timerEnd.mp3"></audio>

    <audio id="auto_sound" src="${pageContext.request.contextPath}/resources/sounds/auto.mp3"></audio>
    <audio id="baby_sound" src="${pageContext.request.contextPath}/resources/sounds/babyNew.mp3"></audio>
    <audio id="beanbag_sound" src="${pageContext.request.contextPath}/resources/sounds/beanbag.mp3"></audio>
    <audio id="bus_sound" src="${pageContext.request.contextPath}/resources/sounds/bus.mp3"></audio>
    <audio id="cat_sound" src="${pageContext.request.contextPath}/resources/sounds/cat.mp3"></audio>

    <audio id="cock_sound" src="${pageContext.request.contextPath}/resources/sounds/cock.mp3"></audio>
    <audio id="coins_sound" src="${pageContext.request.contextPath}/resources/sounds/coins2.mp3"></audio>
    <audio id="cow_sound" src="${pageContext.request.contextPath}/resources/sounds/cow.mp3"></audio>
    <audio id="dog_sound" src="${pageContext.request.contextPath}/resources/sounds/dog.mp3"></audio>
    <audio id="drum_sound" src="${pageContext.request.contextPath}/resources/sounds/drum.mp3"></audio>

    <audio id="goose_sound" src="${pageContext.request.contextPath}/resources/sounds/goose.mp3"></audio>
    <audio id="guitar_sound" src="${pageContext.request.contextPath}/resources/sounds/guitar.mp3"></audio>
    <audio id="gun_sound" src="${pageContext.request.contextPath}/resources/sounds/gun.mp3"></audio>
    <audio id="helicopter_sound" src="${pageContext.request.contextPath}/resources/sounds/helicopter.mp3"></audio>
    <audio id="mosquito_sound" src="${pageContext.request.contextPath}/resources/sounds/mosquito.mp3"></audio>

    <audio id="ocean_sound" src="${pageContext.request.contextPath}/resources/sounds/ocean.mp3"></audio>
    <audio id="plane_sound" src="${pageContext.request.contextPath}/resources/sounds/plane.mp3"></audio>
    <audio id="ring_sound" src="${pageContext.request.contextPath}/resources/sounds/ring.mp3"></audio>
    <audio id="ship_sound" src="${pageContext.request.contextPath}/resources/sounds/ship.mp3"></audio>
    <audio id="whatsapp_sound" src="${pageContext.request.contextPath}/resources/sounds/whatsapp.mp3"></audio>

    <script>

        let stopwatch = document.getElementById('stopwatch');

        let timerEnd = document.getElementById('timerEnd');

        let auto_sound = document.getElementById('auto_sound');
        let baby_sound = document.getElementById('baby_sound');
        let beanbag_sound = document.getElementById('beanbag_sound');
        let bus_sound = document.getElementById('bus_sound');
        let cat_sound = document.getElementById('cat_sound');

        let cock_sound = document.getElementById('cock_sound');
        let coins_sound = document.getElementById('coins_sound');
        let cow_sound = document.getElementById('cow_sound');
        let dog_sound = document.getElementById('dog_sound');
        let drum_sound = document.getElementById('drum_sound');

        let goose_sound = document.getElementById('goose_sound');
        let guitar_sound = document.getElementById('guitar_sound');
        let gun_sound = document.getElementById('gun_sound');
        let helicopter_sound = document.getElementById('helicopter_sound');
        let mosquito_sound = document.getElementById('mosquito_sound');

        let ocean_sound = document.getElementById('ocean_sound');
        let plane_sound = document.getElementById('plane_sound');
        let ring_sound = document.getElementById('ring_sound');
        let ship_sound = document.getElementById('ship_sound');
        let whatsapp_sound = document.getElementById('whatsapp_sound');


        let cards = [{sound:auto_sound, picture:'./resources/images/auto.jpg'},
            {sound:baby_sound, picture:'./resources/images/miron.jpg'},
            {sound:beanbag_sound, picture:'./resources/images/beanbag.jpg'},
            {sound:bus_sound, picture:'./resources/images/bus.jpg'},
            {sound:cat_sound, picture:'./resources/images/cat.jpg'},

            {sound:cock_sound, picture:'./resources/images/cock.jpg'},
            {sound:coins_sound, picture:'./resources/images/coins.jpg'},
            {sound:cow_sound, picture:'./resources/images/cow.jpg'},
            {sound:dog_sound, picture:'./resources/images/gru.jpg'},
            {sound:drum_sound, picture:'./resources/images/drum.jpg'},

            {sound:goose_sound, picture:'./resources/images/goose.jpg'},
            {sound:guitar_sound, picture:'./resources/images/guitar.jpg'},
            {sound:gun_sound, picture:'./resources/images/gun.jpg'},
            {sound:helicopter_sound, picture:'./resources/images/helicopter.jpg'},
            {sound:mosquito_sound, picture:'./resources/images/mosquito.jpg'},

            {sound:ocean_sound, picture:'./resources/images/ocean.jpg'},
            {sound:plane_sound, picture:'./resources/images/plane.jpg'},
            {sound:ring_sound, picture:'./resources/images/ring.jpg'},
            {sound:ship_sound, picture:'./resources/images/ship.jpg'},
            {sound:whatsapp_sound, picture:'./resources/images/whatsapp.jpg'},]

        function shuffle(array) {
            let currentIndex = array.length,  randomIndex;

            // While there remain elements to shuffle...
            while (currentIndex != 0) {

                // Pick a remaining element...
                randomIndex = Math.floor(Math.random() * currentIndex);
                currentIndex--;

                // And swap it with the current element.
                [array[currentIndex], array[randomIndex]] = [
                    array[randomIndex], array[currentIndex]];
            }

            return array;
        }

        shuffle(cards);

        let array8 = [cards[0], cards[1], cards[2], cards[3], cards[4], cards[5], cards[6], cards[7]];

        $(document).ready(function() {

            $("#buttonStart").click(function () {
                setTimeout(function () {
                    // let card = document.getElementById(String(1));
                    $('#1').addClass('border border-primary');
                    array8[0].sound.play();
                    let currentIndex = 1;
                    let soundRow = setInterval(function() {
                        // alert(sounds[currentIndex].constructor.name);
                        let card = document.getElementById(String(currentIndex + 1));

                        $(card).addClass('border border-primary');
                        array8[currentIndex].sound.play();
                        if(++currentIndex>=array8.length) {
                            clearInterval(soundRow);
                        }
                    }, 6000);
                }, 3000);
            });

            $(".card-img").click(function () {
                let clickedImage = this;
                let order = Number(clickedImage.id) - 1;
                $(clickedImage).fadeOut(function() {
                        clickedImage.src=array8[order].picture;
                        $(clickedImage).fadeIn();
                    setTimeout(function () {
                        array8[order].sound.play();
                    }, 400);
                });

            });

            $("#timer").click(function () {
                $("#timer").attr("disabled", true);
                let timeRemain = 59;
                stopwatch.addEventListener('ended', function(){
                    timerEnd.play();
                });
                stopwatch.play();
                setTimeout(countdown, 1000);
                function countdown() {
                    let displaySec = timeRemain < 10 ? "0" + timeRemain : timeRemain;
                    document.getElementById("timer").innerHTML = "0:" + displaySec;
                    timeRemain--;
                    if(timeRemain >= 0) {
                        setTimeout(countdown, 1000);
                    }
                }

            });


        });

    </script>

</head>

<body>
<div class="container">
    <div class="row mt-5 mb-5">

    </div>
    <div class="row mt-5 mb-5">
        <div class="col">
            <div class="card">
                <img class="card-img" id="1" src="./resources/images/one.jpg" alt="...">
            </div>
        </div>
        <div class="col">
            <div class="card">
                <img class="card-img" id="2" src="./resources/images/two.jpg" alt="...">
            </div>
        </div>
        <div class="col">
            <div class="card">
                <img class="card-img" id="3" src="./resources/images/three.jpg" alt="...">
            </div>
        </div>
        <div class="col">
            <div class="card">
                <img class="card-img" id="4" src="./resources/images/four.jpg" alt="...">
            </div>
        </div>

    </div>
    <div class="row mt-5 mb-5">
        <div class="col">
            <div class="card">
                <img class="card-img" id="5" src="./resources/images/five.jpg" alt="...">
            </div>
        </div>
        <div class="col">
            <div class="card">
                <img class="card-img" id="6" src="./resources/images/six.jpg" alt="...">
            </div>
        </div>
        <div class="col">
            <div class="card">
                <img class="card-img" id="7" src="./resources/images/seven.jpg" alt="...">
            </div>
        </div>
        <div class="col">
            <div class="card">
                <img class="card-img" id="8" src="./resources/images/eight.jpg" alt="...">
            </div>
        </div>

    </div>
    <div class="row mt-5 mb-5">
        <div class="col">
            <button type="button" id="buttonStart" class="btn btn-outline-primary btn-lg" data-toggle="button" aria-pressed="false">Звуковой ряд</button>
        </div>
        <div class="col text-right">
            <button type="button" id="timer" class="btn btn-outline-danger btn-lg" data-toggle="button" aria-pressed="false">1:00</button>
        </div>
    </div>

</div>

</body>