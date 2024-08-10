import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../models/location_model.dart';
import '../../../models/weather_model.dart';

class WeatherService {
  
  Future<List<WeatherModel>> fetchWeatherReports(
      List<LocationModel> locations) async {

    List<WeatherModel> weatherReports = [];

    for (var location in locations) {
      final response = await http.get(Uri.parse(
          '$baseUrl/data/2.5/weather?q=${location.city}&appid=$apiKey'));
      if (response.statusCode == 200) {
        weatherReports.add(WeatherModel.fromJson(json.decode(response.body)));
      } else if (response.statusCode == 404) {
        throw Exception('Weather data not found for city: ${location.city}');
      } else {
        throw Exception('Failed to fetch weather data.');
      }
    }
    
    return weatherReports;
  }
}
