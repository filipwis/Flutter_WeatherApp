import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_weather_app/layout/screens/SearchScreen.dart';
import 'package:flutter_weather_app/layout/widgets/FavouritePlacesSidebar.dart';
import 'package:flutter_weather_app/layout/widgets/HourPicker.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isChecked = false;
  var isSideBarOpen = false;
  late Position _position;

  void _changeSidebarState() {
    setState(() {
      isSideBarOpen = !isSideBarOpen;
    });
  }

  @override
  void initState() {
    _determinePosition().then((Position position) {
      setState(() {
        _position = position;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    return Scaffold(
        body: SafeArea(
            child: Stack(
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
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () => {setState(() => isChecked = !isChecked)},
                    icon: isChecked
                        ? darkModeOn
                            ? Image.asset('assets/heart-white-outline.png')
                            : Image.asset('assets/heart.png')
                        : Image.asset('assets/heart-red.png')),
                SizedBox(width: 25.0),
                Text(
                  'Zakopane',
                  style: TextStyle(fontSize: 40.0),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text('16°',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.w600))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '21.06.2021',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 70.0,
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
                        child: Image.asset('assets/storm.png'),
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
                              builder: (BuildContext context) => HourPicker())
                        },
                        child: Text(
                          '13:00',
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Container(
                height: 170,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Wtorek',
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
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      children: [
                        Text(
                          'Środa',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          '15°',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          child: Image.asset('assets/windy.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      children: [
                        Text(
                          'Czwartek',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          '20°',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          child: Image.asset('assets/rainy.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      children: [
                        Text(
                          'Piątek',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          '22°',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          child: Image.asset('assets/sun.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      children: [
                        Text(
                          'Sobota',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          '19°',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          child: Image.asset('assets/storm-and-rain.png'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        isSideBarOpen ? FavouritePalceSidebar(_changeSidebarState) : SizedBox(),
      ],
    )));
  }

  Future<Position> _determinePosition() async {
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

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
