import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/data/Weather.dart';
import 'package:flutter_weather_app/data/WeatherRepository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchDataByLocation) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeatherByLocation(
            event.latitude, event.longtitude);
        yield WeatherLoaded(weather: weather);
      } catch (e) {
        print(e);
      }
    }
  }
}
