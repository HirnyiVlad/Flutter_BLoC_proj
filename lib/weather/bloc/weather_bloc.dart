import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_scutum_task/data/network_provider/weather_api.dart';

import '../model/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

// BLoC
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherApi weatherApi;

  WeatherBloc(this.weatherApi) : super(WeatherInitialState()) {
    on<FetchWeatherEvent>(_onFetchWeather);
  }
//Making request to Api
  Future<void> _onFetchWeather(FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());

    try {
      final data = await weatherApi.fetchData();
      final currentWeather = CurrentWeather.fromJson(data);
      emit(WeatherLoadedState(currentWeather));
    } catch (error) {
      emit(WeatherErrorState('Failed to fetch weather data: $error'));
    }
  }
}