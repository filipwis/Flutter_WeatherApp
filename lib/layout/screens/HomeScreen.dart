import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/layout/screens/SearchScreen.dart';
import 'package:flutter_weather_app/layout/widgets/FavouritePlacesSidebar.dart';
import 'package:flutter_weather_app/layout/widgets/HourPicker.dart';
import 'package:flutter_weather_app/logic/bloc/weather_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isChecked = false;
  var isSideBarOpen = false;
  var hour = "12:00";
  DateTime now = DateTime.now();

  set forecast(forecast) {}

  void _changeSidebarState() {
    setState(() {
      isSideBarOpen = !isSideBarOpen;
    });
  }

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    return Scaffold(
        body: SafeArea(child: BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded)
          return Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen()));
                            },
                            icon: Icon(
                              Icons.search,
                              size: 35.0,
                            )),
                        IconButton(
                            onPressed: () => {_changeSidebarState()},
                            icon: darkModeOn
                                ? Image.asset('assets/menu-white-outline.png')
                                : Image.asset('assets/menu.png')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => {
                                setState(() => isChecked = !isChecked),
                              },
                          icon: !isChecked
                              ? darkModeOn
                                  ? Image.asset(
                                      'assets/heart-white-outline.png')
                                  : Image.asset('assets/heart.png')
                              : Image.asset('assets/heart-red.png')),
                      SizedBox(width: 10.0),
                      Text(
                        state.weather.cityName,
                        style: TextStyle(fontSize: 35.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(state.weather.temperature.substring(0, 2) + '°',
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    DateFormat('dd.MM.yyyy').format(now),
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 160,
                        child: Column(
                          children: [
                            Text(
                              'Pogoda',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 120,
                              height: 120,
                              child: Image.asset(
                                  _getWeatherIcon(state.weather.icon)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 160,
                        child: Column(
                          children: [
                            Text(
                              'Godzina',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            SizedBox(
                              height: 55,
                            ),
                            GestureDetector(
                              onTap: () => {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        HourPicker())
                              },
                              child: Text(
                                DateFormat('Hm').format(state.weather.date),
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Container(
                        height: 170,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Column(
                                  children: [
                                    Text(
                                      _getWeekday(now.weekday + index + 1),
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      '13°',
                                      style: TextStyle(fontSize: 30.0),
                                    ),
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: Image.asset('assets/storm.png'),
                                    ),
                                  ],
                                ),
                              );
                            })),
                  )
                ],
              ),
              isSideBarOpen
                  ? FavouritePalceSidebar(_changeSidebarState)
                  : SizedBox(),
            ],
          );
        return Text('Loading...');
      },
    )));
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    BlocProvider.of<WeatherBloc>(context).add(FetchDataByLocation(
        latitude: position.latitude.toString(),
        longtitude: position.longitude.toString()));
  }

  _getWeatherIcon(String icon) {
    switch (icon) {
      case '01d':
        return "assets/sun.png";
      case '01n':
        return "assets/sun.png";
      case '02d':
      case '02n':
      case '03d':
      case '03n':
      case '04d':
      case '04n':
        return "assets/cloudy.png";
      case '09d':
      case '09n':
      case '10d':
      case '10n':
        return "assets/rainy.png";
      case '11d':
      case '11n':
        return "assets/storm.png";
      case '13d':
      case '13n':
        return "assets/windy.png";
      case '50d':
      case '50n':
        return "assets/windy.png";
    }
  }

  _getWeekday(int day) {
    if (day > 7) {
      day -= 7;
    }
    switch (day) {
      case 1:
        return "Poniedziałek";
      case 2:
        return "Wtorek";
      case 3:
        return "Środa";
      case 4:
        return "Czwartek";
      case 5:
        return "Piątek";
      case 6:
        return "Sobota";
      case 7:
        return "Niedziela";
    }
  }
}
