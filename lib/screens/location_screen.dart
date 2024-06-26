import 'package:clima_flutter/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clima_flutter/utilities/constants.dart';
import 'package:clima_flutter/services/weather.dart';
import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/screens/userprofile.dart';
import 'package:clima_flutter/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});

  final locationweather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String textmsg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget
        .locationweather); //cause we are accessiong a widget inside LocationScreen widget and it needs to be used
  }

  void updateUI(dynamic weatherdata) {
    setState(() {
      double temp = weatherdata['main']['temp'];
      if (temp.runtimeType == double) {
        temperature = temp.toInt();
      } else
        temperature = temp as int;
      var condition = weatherdata['weather'][0]['id'];
      cityName = weatherdata['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      textmsg = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // to avoid renderoverflow while going to locationscreen from cityscreen
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getweatherData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => userprofile()));
                    },
                    child: Icon(
                      Icons.add_box_rounded,
                      size: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (cityName != null) {
                        var weatherdata = weather.getweatherCity(cityName);
                        updateUI(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$textmsg in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
