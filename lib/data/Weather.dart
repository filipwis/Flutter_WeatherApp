class Weather {
  String cityName;
  String temperature;
  String icon;
  List<Weather>? forecast;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.icon,
    this.forecast,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    String cityName = json["city"]["name"];
    String temp = "";
    List<Weather> weatherForecast = [];
    for (final item in json["list"]) {
      if (item["temp"]["day"].toString().contains(".")) {
        temp = item["temp"]["day"]
            .toString()
            .substring(0, item["temp"]["day"].toString().indexOf("."));
      } else {
        temp = item["temp"]["day"].toString();
      }
      weatherForecast.add(Weather(
          cityName: cityName,
          temperature: temp,
          icon: item["weather"][0]["icon"]));
    }
    return Weather(
        cityName: json["city"]["name"],
        temperature: weatherForecast[0].temperature,
        icon: weatherForecast[0].icon,
        forecast: weatherForecast);
  }
}


// http://pro.openweathermap.org/data/2.5/forecast/hourly?q=London&lang=pl&units=metric&appid=f1a839e6b114796ba95c634735d5281b