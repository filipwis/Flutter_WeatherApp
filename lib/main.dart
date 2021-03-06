import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/layout/screens/HomeScreen.dart';
import 'package:flutter_weather_app/logic/bloc/weather_bloc.dart';
import 'package:flutter_weather_app/logic/cubit/forecast_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/WeatherRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository = WeatherRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(weatherRepository)),
        BlocProvider<ForecastCubit>(
          create: (context) => ForecastCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.grey,
        ),
        darkTheme: ThemeData(
          fontFamily: 'Lato',
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
