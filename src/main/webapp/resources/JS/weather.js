var apiURL =
"https://api.openweathermap.org/data/2.5/onecall?lat=37.5&lon=127.03&exclude=hourly&appid=369ede1bcce0a7238c08e1b79924eadc";

$.ajax({
url: apiURL,
type: "get",
dataType: "json",
async: "false",
success: function (resp) {

    for (i = 1; i < 4; i++) {
        var test = String(resp.daily[i].weather[0].main);
        //alert(test);
        var compareh = resp.daily[i].humidity;
        var comparet = (resp.daily[i].temp.day - 273).toFixed(1);
        // $('#day'+i+'').html(test);
        $('#day'+i+'').addClass('wi wi-rain');

        
    }

    var compareh = resp.daily[0].humidity;
    var comparet = (resp.daily[0].temp.day - 273).toFixed(1);
    var weather = String(resp.daily[0].weather[0].main);
    var weather2 = String(resp.daily[1].weather[0].main);
    var weather3 = String(resp.daily[2].weather[0].main);
    var weather4 = String(resp.daily[3].weather[0].main);
    // alert(temp);
    $('currently-weather').html(weather);
    $('.temperature').html(comparet + " ºC<br><br>" + compareh + "%");

    //alert(weather);

    if (weather === 'Rain') {
        if (comparet > 20) {

            if (compareh > 80 && compareh <= 100) {
                $(document).ready(function () {
                    $('#icon').addClass('wi wi-rain');
                });
            } else if (compareh > 50 && compareh < 80) {
                $(document).ready(function () {
                    $('#icon').addClass('wi wi-rain-mix');
                });
            }



        } else if (comparet > 24) {
            if (compareh > 80 && compareh <= 100) {
                $(document).ready(function () {
                    $('#icon').addClass('wi wi-rain');
                });
            } else if (compareh > 50 && compareh < 80) {
                $(document).ready(function () {
                    $('#icon').addClass('wi wi-rain-mix');
                });
            }
        } else if (comparet > 29) {
            if (compareh > 80 && compareh <= 100) {
                $(document).ready(function () {
                    $('#icon').addClass('wi wi-day-rain');
                });
            } else if (compareh > 50 && compareh < 80) {
                $(document).ready(function () {
                    $('#icon').addClass('wi wi-day-rain-mix');
                });
            }

        }
    } else if (weather === 'Clouds') {
        if (comparet > 24) {
            $(document).ready(function () {
                $('#icon').addClass('wi wi-cloud');
            });
        } else if (comparet > 29) {
            $(document).ready(function () {
                $('#icon').addClass('wi wi-day-cloudy');
            });
        }
    } else if (weather === 'Clear') {
        if (comparet > 24) {
            $(document).ready(function () {
                $('#icon').addClass('wi wi-day-sunny');
            });
        } else if (comparet > 29) {
            $(document).ready(function () {
                $('#icon').addClass('wi wi-hot');
            });
        }
    } else {
        $(document).ready(function () {
            $('#icon').addClass('wi wi-day-cloudy-gusts');
        });
    }





}
//alert(resp.daily.length);
});