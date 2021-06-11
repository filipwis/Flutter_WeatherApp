import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/logic/bloc/weather_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _cityName = GlobalKey<FormState>();
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Form(
                  key: _cityName,
                  child: Column(children: [
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: controller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Wprowadź nazwę miejscowości';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Wyszukaj miejscowości',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_cityName.currentState!.validate()) {
                            Navigator.pop(context);
                            BlocProvider.of<WeatherBloc>(context).add(
                                FetchDataByCityName(
                                    cityName: controller.value.text));
                          }
                        },
                        child: Text(
                          "Wyszukaj",
                        ))
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
