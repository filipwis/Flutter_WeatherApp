import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
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
}
