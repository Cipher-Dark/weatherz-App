part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final Position position;

  const FetchWeather(this.position);
  @override
  List<Object> get props => [
        position
      ];
}

class FetchWeatherByCity extends WeatherEvent {
  final String cityNme;

  const FetchWeatherByCity({required this.cityNme});
  @override
  List<Object> get props => [
        cityNme
      ];
}
