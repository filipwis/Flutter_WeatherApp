import 'dart:convert';

import 'package:flutter_weather_app/data/WeatherApiClient.dart';
import 'package:http/http.dart' as http;
import 'Weather.dart';

class WeatherRepository {
  // final WeatherApiClient weatherApiClient;
  // WeatherRepository({required this.weatherApiClient});

  // Future<String> getWeather(
  //     String cityName, double latitude, double longtitude) async {
  //   var jsonData = weatherApiClient.fetchWeatherDataByCoordiantes(
  //       latitude: latitude, longtitude: longtitude);
  //   return jsonData;
  // }
  Future<Weather> getWeatherByLocation(
      String latitude, String longtitude) async {
    final queryParameters = {
      'lang': 'pl',
      'units': 'metric',
      'lat': latitude,
      'lon': longtitude,
      'appid': 'f1a839e6b114796ba95c634735d5281b'
    };

    final uri = Uri.http(
        'pro.openweathermap.org', '/data/2.5/forecast/hourly', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load the weather data');
    }
  }

  Future<Weather> getWeatherByCityName(String cityName) async {
    final queryParameters = {
      'lang': 'pl',
      'units': 'metric',
      'q': cityName,
      'appid': 'f1a839e6b114796ba95c634735d5281b'
    };

    final uri = Uri.http(
        'pro.openweathermap.org', '/data/2.5/forecast/hourly', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load the weather data');
    }
  }
}
