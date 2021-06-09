import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {
  String cityName;
  DateTime date;
  String temperature;
  String icon;
  List<Weather>? forecast;

  Weather({
    required this.cityName,
    required this.date,
    required this.temperature,
    required this.icon,
    this.forecast,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    String cityName = json["city"]["name"];
    String currentTemp = "";
    String temp = "";
    List<Weather> weatherForecast = [];
    for (final item in json["list"]) {
      if (item["main"]["temp"].toString().contains(".")) {
        temp = item["main"]["temp"]
            .toString()
            .substring(0, item["main"]["temp"].toString().indexOf("."));
      } else {
        temp = item["main"]["temp"].toString();
      }
      weatherForecast.add(Weather(
          cityName: cityName,
          date: DateTime.parse(item["dt_txt"]),
          temperature: temp,
          icon: item["weather"][0]["icon"]));
    }
    if (json["list"][0]["main"]["temp"].toString().contains(".")) {
      currentTemp = json["list"][0]["main"]["temp"].toString().substring(
          0, json["list"][0]["main"]["temp"].toString().indexOf("."));
    } else {
      currentTemp = json["list"][0]["main"]["temp"].toString();
    }
    return Weather(
        cityName: json["city"]["name"],
        date: DateTime.parse(json["list"][0]["dt_txt"]),
        temperature: currentTemp,
        icon: json["list"][0]["weather"][0]["icon"],
        forecast: weatherForecast);
  }

  Weather getForecastTemp(int day, int hour) {
    return this.forecast!.firstWhere(
        (element) => element.date.day == day && element.date.hour == hour);
  }
}


// http://pro.openweathermap.org/data/2.5/forecast/hourly?q=London&lang=pl&units=metric&appid=f1a839e6b114796ba95c634735d5281b