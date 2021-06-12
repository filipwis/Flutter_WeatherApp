import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/logic/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

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
                            FocusScope.of(context).unfocus();
                            _checkIfCity(controller.value.text);
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

  _checkIfCity(String input) async {
    final queryParameters = {
      'q': input,
      'appid': 'f1a839e6b114796ba95c634735d5281b'
    };
    final uri =
        Uri.http('api.openweathermap.org', 'geo/1.0/direct', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      if (response.body != "[]") {
        BlocProvider.of<WeatherBloc>(context)
            .add(FetchDataByCityName(cityName: controller.value.text));
        Navigator.of(context).pop();
      } else
        _showAlert();
    } else {
      _showAlert();
    }
  }

  _showAlert() {
    controller.clear();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Nie możemy pobrać prognozy z podanej lokalizacji 😓",
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        });
  }
}
