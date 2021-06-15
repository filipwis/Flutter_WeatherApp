import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> with HydratedMixin {
  ForecastCubit()
      : super(
          ForecastState(days: 4, cities: []),
        );

  void changeCountOfDays(int value) {
    emit(ForecastState(days: value, cities: state.cities));
  }

  void addFavCity(String city) {
    emit(ForecastState(days: state.days, cities: state.cities..add(city)));
  }

  void removeFavCity(String city) {
    emit(ForecastState(days: state.days, cities: state.cities..remove(city)));
  }

  @override
  ForecastState? fromJson(Map<String, dynamic> json) {
    return ForecastState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ForecastState state) {
    return state.toMap();
  }
}
