
            function loadingScripts()
            {
            weatherCode();
            putTemperatureIcon();

            }

            function putTemperatureIcon()
            {
            var temptext =document.getElementById("temperature_value").innerHTML
            var x =temperatureIcon(temptext);
            document.getElementById("tempicon").src=x;
            }

            function temperatureIcon(temperature)
            {
            var i
            var firstchar

            firstchar=temperature.charAt(0)

            switch (firstchar)
            {
            case "3":
            i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/30-40.png";
            break;
            case "4":
            i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/40-50.png";
            break;
            case "5":
            i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/50-60.png";
            break;
            case "6":
            i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/60-70.png";
            break;
            case "7":
            i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/70-80.png";
            break;
            case "8":
            i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/80-90.png";
            break;
            case "9":
            i="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/90-100.png";
            break;
            default:
            i="out of range";
            break;
            }
            return i;
            }
            function weatherCode()
            {
            var str = document.getElementById("weather").innerHTML

            var reg1 =new RegExp("/Fog|Haze|Clear|Fair|Mostly Cloudy|A Few Clouds|Overcast|Partly Cloudy|Rain|Freezing Rain|Drizzle|Freezing Drizzle|Light Rain|Showers|Rain Showers|Showers Rain|Snow|Ice Pellets|Hail|Thunderstorm/");

            y=reg1.exec(str);

            z=weatherIcon(y[0]);

            document.getElementById("weather_icon").src=z;
            }

            function weatherIcon(weatherExpression)
            {

            var w
            switch (weatherExpression)
            {
            case "Fog"||"Haze":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/fg.jpg";
            break;
            case "Fair"||"Clear":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/skc.jpg";
            break;
            case "Mostly Cloudy":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/bkn.jpg";
            break;
            case "A Few Clouds":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/sct.jpg";
            break;
            case "Partly Cloudy":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/pcloudy.jpg";
            break;
            case "Overcast":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/ovc.jpg";
            break;
            case "Rain":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/shra.jpg";
            break;
            case "Light Rain"||"Drizzle":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/ra1.jpg";
            break;
            case "Freezing Rain"||"Freezing Drizzle":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/fzrara.jpg";
            break;
            case "Rain Showers"||"Showers"||"Showers Rain":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/shra.jpg";
            break;
            case "Snow":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/sn.jpg";
            break;
            case "Thunderstorm":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/tsra.jpg";
            break;
            case "Ice Pellets"||"Hail":
            w="http://spu-sharepoint/DWWQ/Teams/SOPA/Graphics/ip.jpg";
            break;
            default:
            w=weatherExpression;
            break;
            }
            return w;
            }
      