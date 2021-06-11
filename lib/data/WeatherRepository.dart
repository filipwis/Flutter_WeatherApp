import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Weather.dart';

class WeatherRepository {
  Future<Weather> getWeatherByLocation(
      String latitude, String longtitude) async {
    final queryParameters = {
      'cnt': '12',
      'lang': 'pl',
      'units': 'metric',
      'lat': latitude,
      'lon': longtitude,
      'appid': 'f1a839e6b114796ba95c634735d5281b'
    };

    final uri = Uri.http(
        'api.openweathermap.org', 'data/2.5/forecast/daily', queryParameters);

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
      'q': cityName,
      'cnt': '12',
      'lang': 'pl',
      'units': 'metric',
      'appid': 'f1a839e6b114796ba95c634735d5281b'
    };

    final uri = Uri.http(
        'api.openweathermap.org', 'data/2.5/forecast/daily', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load the weather data');
    }
  }
}
