import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(
      (event, emit) async {
        emit(WeatherLoading());
        try {
          WeatherFactory weatherFactory = WeatherFactory("${dotenv.env['apiKey']}", language: Language.ENGLISH);

          Weather weather = await weatherFactory.currentWeatherByLocation(
            event.position.altitude,
            event.position.longitude,
          );
          emit(WeatherSuccess(weather));
        } catch (e) {
          emit(WeatherFailure());
        }
      },
    );
    on<FetchWeatherByCity>(
      (event, emit) async {
        emit(WeatherLoading());
        try {
          WeatherFactory weatherFactory = WeatherFactory("${dotenv.env['apiKey']}", language: Language.ENGLISH);
          Weather weather = await weatherFactory.currentWeatherByCityName(event.cityNme);
          emit(WeatherSuccess(weather));
        } catch (e) {
          emit(WeatherFailure());
        }
      },
    );
  }
}
