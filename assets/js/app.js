// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"


$(".rental_time").each(countdown)

function countdown(){
    var countDownDate = new Date($(this).text()).getTime();
    var that = $(this).get(0);
// Update the count down every 1 second
    var x = setInterval(function() {
        // Get todays date and time
        var now = new Date().getTime();

        // Find the distance between now and the count down date
        var distance = countDownDate - now;
        // Time calculations for days, hours, minutes and seconds
        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // Output the result in an element with id="demo"
        that.innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";
        /* console.log( days + "d " + hours + "h " + minutes + "m " + seconds + "s ");
         */
        // If the count down is over, write some text
        if (distance < 0) {
            clearInterval(x);
            that.innerHTML = "EXPIRED";
        }
    }, 1000);
}


$(".preview").on('canplay', function(){
    $(this).mouseenter(function(){
        $(this).get(0).play();
        var that = $(this)
        setTimeout(function() {that.get(0).currentTime=0; that.get(0).pause()}, 2000)
    }).mouseleave(function(){
        $(this).get(0).pause();
    })
});





// import "assets/js/timer.js"
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
