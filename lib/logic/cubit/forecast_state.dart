part of 'forecast_cubit.dart';

class ForecastState {
  final int days;
  final List<String> cities;

  ForecastState({required this.days, required this.cities});

  Map<String, dynamic> toMap() {
    return {
      'days': days,
      'cities': cities,
    };
  }

  factory ForecastState.fromMap(Map<String, dynamic> map) {
    return ForecastState(
      days: map['days'],
      cities: List<String>.from(map['cities']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastState.fromJson(String source) =>
      ForecastState.fromMap(json.decode(source));
}
