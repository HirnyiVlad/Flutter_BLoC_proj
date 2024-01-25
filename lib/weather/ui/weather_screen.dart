import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_scutum_task/weather/ui/styled_text_weather.dart';
import '../../data/network_provider/weather_api.dart';
import '../bloc/weather_bloc.dart';
class WeatherScreen extends StatefulWidget {
  final WeatherApi weatherApi;

  const WeatherScreen({
    Key? key,
    required this.weatherApi,
  }) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    // Initialize WeatherBloc with the provided weatherApi
    _weatherBloc = WeatherBloc(widget.weatherApi);
    // Trigger the FetchWeatherEvent when the screen is initialized
    _weatherBloc.add(FetchWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: const Text('Current Weather'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen when the back button is pressed
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: _weatherBloc,
        builder: (context, state) {
          if (state is WeatherLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherLoadedState) {
            final currentWeather = state.weather;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display weather information using WeatherText widget
                  WeatherText(text: 'Location: ${currentWeather.name}'),
                  WeatherText(text:'Temperature: ${currentWeather.main.temp} °C'),
                  WeatherText(text:'Feels Like: ${currentWeather.main.feelsLike} °C'),
                  WeatherText(text:'Min Temperature: ${currentWeather.main.tempMin} °C'),
                  WeatherText(text:'Max Temperature: ${currentWeather.main.tempMax} °C'),
                  WeatherText(text:'Pressure: ${currentWeather.main.pressure} hPa'),
                  WeatherText(text:'Humidity: ${currentWeather.main.humidity}%'),
                ],
              ),
            );
          } else if (state is WeatherErrorState) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // Close the WeatherBloc when the screen is disposed to avoid memory leaks
    _weatherBloc.close();
    super.dispose();
  }
}
