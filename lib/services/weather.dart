import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';

const apiKey = '784f008cf048ee86aca6c6dd3536cdbf';
const weatherAPI = 'https://api.openweathermap.org/data/2.5/weather';


class WeatherModel {
  Future <dynamic> getweatherData() async {
    location Location = location(); //it is called calling an object
    await Location.getCurrentlocation();

    // getData() shifted from initstate we did this to make sure we dont pass any empty latitude or longitude data
    NetworkHelper networkHelper = NetworkHelper(
        '$weatherAPI?lat=${Location.latitude}&lon=${Location.longitude }&appid=$apiKey&units=metric');
    var weatherdata = await networkHelper.getData();
    return weatherdata;
  }

  Future<dynamic> getweatherCity(String weathercity) async
  {
    var url = '$weatherAPI?q=$weathercity&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;

  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
