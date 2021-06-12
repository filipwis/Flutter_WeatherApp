import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/logic/cubit/forecast_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Builder(builder: (context) {
        final forecastState = context.watch<ForecastCubit>().state;
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 35,
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ustawienia",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Okres prognozy:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    RadioListTile<int>(
                      title: const Text('5 dni'),
                      value: 4,
                      groupValue: forecastState.days,
                      onChanged: (int? val) {
                        setState(() {
                          BlocProvider.of<ForecastCubit>(context)
                              .changeCountOfDays(val!);
                        });
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('7 dni'),
                      value: 6,
                      groupValue: forecastState.days,
                      onChanged: (int? val) {
                        setState(() {
                          BlocProvider.of<ForecastCubit>(context)
                              .changeCountOfDays(val!);
                        });
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('14 dni'),
                      value: 13,
                      groupValue: forecastState.days,
                      onChanged: (int? val) {
                        setState(() {
                          BlocProvider.of<ForecastCubit>(context)
                              .changeCountOfDays(val!);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      })),
    );
  }
}
