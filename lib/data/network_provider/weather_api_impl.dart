import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_api.dart';

//Used package:http/http.dart to make HTTP request,
// because it's suitable for interacting with HTTP APIs.

class WeatherApiImpl implements WeatherApi {

  @override
  Future<Map<String, dynamic>> fetchData() async {
    // API endpoint URL for fetching weather data
    const url ='https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=65b456458afe7c199a809a408199d7af';

    // Making an HTTP GET request to the specified URL
    final response = await http.get(Uri.parse(url));

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Decode the JSON response body into a Map
      return json.decode(response.body);
    } else {
      // Throw an exception if the response status code is not 200
      throw Exception('Failed to fetch data');
    }
  }
}