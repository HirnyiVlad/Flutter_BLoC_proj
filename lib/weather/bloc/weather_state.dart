part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final CurrentWeather weather;

  WeatherLoadedState(this.weather);
}

class WeatherErrorState extends WeatherState {
  final String error;

  WeatherErrorState(this.error);
}
