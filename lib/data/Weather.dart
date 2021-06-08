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
    List<Weather> weatherForecast = [];
    for (final item in json["list"]) {
      weatherForecast.add(Weather(
          cityName: cityName,
          date: DateTime.parse(item["dt_txt"]),
          temperature: item["main"]["temp"].toString(),
          icon: item["weather"][0]["icon"]));
    }
    return Weather(
        cityName: json["city"]["name"],
        date: DateTime.parse(json["list"][0]["dt_txt"]),
        temperature: json["list"][0]["main"]["temp"].toString(),
        icon: json["list"][0]["weather"][0]["icon"],
        forecast: weatherForecast);
  }
}
