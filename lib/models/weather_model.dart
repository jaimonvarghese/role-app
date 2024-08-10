class WeatherModel {
  final String city;
  final double temperature;

  WeatherModel({required this.city, required this.temperature});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      temperature: json['main']['temp'] - 273.15, // Convert from Kelvin to Celsius
    );
  }
}
