part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchDataByLocation extends WeatherEvent {
  final String latitude;
  final String longtitude;

  FetchDataByLocation({required this.latitude, required this.longtitude});
}

class FetchDataByCityName extends WeatherEvent {
  final String cityName;

  FetchDataByCityName({required this.cityName});
}
