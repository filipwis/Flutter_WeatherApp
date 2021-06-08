import 'dart:convert';
import 'package:flutter_weather_app/data/Weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const baseUrl =
      'http://pro.openweathermap.org/data/2.5/forecast/hourly?lang=pl&units=metric';
  final apiKey;
  final http.Client httpClient;

  WeatherApiClient({required this.httpClient, required this.apiKey});

  Future<String> fetchWeatherDataByCoordiantes(
      {required double latitude, required double longtitude}) async {
    final url = '$baseUrl&lat=$latitude&lon=$longtitude&appid=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      return data;
    } else {
      throw Exception('Failed to load the weather data');
    }
  }

  Future<List> fetchWeatherData(String cityName) async {
    final url = '$baseUrl&q=$cityName&appid=$apiKey';
    List<Weather> forecast = [];
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      return data;
    } else {
      throw Exception('Failed to load the weather data');
    }
  }
}
