import 'package:dio/dio.dart';
import 'weather_model.dart';

class WeatherService {
  final Dio dio = Dio();
  final String baseUrl = "https://api.weatherapi.com/v1";
  final String apiKey = "03b84b1aedb342f9b1f61120260803 ";

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio.get(
        "$baseUrl/forecast.json",
        queryParameters: {
          "key": apiKey,
          "q": cityName,
          "days": 1,
          "aqi": "no",
          "alerts": "no"
        },
      );

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("City not found or API error");
    } catch (e) {
      throw Exception("Failed to load weather data");
    }
  }
}