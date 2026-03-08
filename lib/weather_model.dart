class WeatherModel {
  final String? cityName;
  final DateTime? date;
  final String? image;
  final double? temp;
  final double? maxTemp;
  final double? minTemp;
  final String? weatherCondition;

  WeatherModel({
    required this.cityName,
    required this.date,
    required this.image,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherCondition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['location']['name'],
      date: DateTime.parse(json['current']['last_updated']),
      image: json['forecast']['forecastday'][0]['day']['condition']['icon'],
      temp: json['current']['temp_c'].toDouble(),
      maxTemp:json['forecast']['forecastday'][0]['day']['maxtemp_c'].toDouble(),
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'].toDouble(),
      weatherCondition: json['forecast']['forecastday'][0]['day']['condition']['text'],
    );
  }
}
