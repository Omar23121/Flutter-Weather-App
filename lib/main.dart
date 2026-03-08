import "package:flutter/material.dart";
import 'weather_service.dart';
import 'weather_model.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الطقس',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: const WeatherHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}




class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  WeatherModel? weatherModel;
  bool isLoading = false;
  String? errorMessage;
  final WeatherService weatherService = WeatherService();
  final TextEditingController cityController = TextEditingController();

  final List<String> saudiCities = [
    "Riyadh",
    "Jeddah",
    "Mecca",
    "Medina",
    "Dammam",
    "Khobar",
    "Dhahran",
    "Abha",
    "Taif",
    "Tabuk",
    "Al Qassim",
    "Hail",
    "Najran",
    "Jazan",
    "Al Bahah",
  ];

  Future<void> getWeather(String cityName) async {
    if (cityName.isEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      WeatherModel weather = await weatherService.getCurrentWeather(
        cityName: cityName,
      );
      setState(() {
        weatherModel = weather;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  MaterialColor getThemeColor(String? condition) {
    if (condition == null) return Colors.blue;

    switch (condition.toLowerCase()) {
      case "sunny":
      case "clear":
        return Colors.orange;
      case "partly cloudy":
        return Colors.blueGrey;
      case "cloudy":
      case "overcast":
        return Colors.grey;
      case "rainy":
      case "light rain":
      case "moderate rain":
        return Colors.blue;
      case "heavy rain":
        return Colors.indigo;
      case "snow":
      case "light snow":
        return Colors.cyan;
      case "thunderstorm":
        return Colors.deepPurple;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      weatherModel != null
          ? getThemeColor(weatherModel!.weatherCondition).shade50
          : Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          'تطبيق الطقس',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor:
        weatherModel != null
            ? getThemeColor(weatherModel!.weatherCondition)
            : Colors.blue,
        elevation: 0,
      ),
      body: Container(
        decoration:
        weatherModel != null
            ? BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              getThemeColor(weatherModel!.weatherCondition),
              getThemeColor(weatherModel!.weatherCondition).shade300,
              getThemeColor(weatherModel!.weatherCondition).shade50,
            ],
          ),
        )
            : BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.blue.shade300,
              Colors.blue.shade50,
            ],
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Section
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: cityController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'أدخل اسم المدينة',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                      onSubmitted: (value) {
                        getWeather(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed:
                      isLoading
                          ? null
                          : () {
                        getWeather(cityController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        weatherModel != null
                            ? getThemeColor(
                          weatherModel!.weatherCondition,
                        )
                            : Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child:
                      isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        'بحث عن الطقس',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Quick Access Cities
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: saudiCities.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        saudiCities[index],
                        style: const TextStyle(fontSize: 12),
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          cityController.text = saudiCities[index];
                          getWeather(saudiCities[index]);
                        }
                      },
                      backgroundColor: Colors.white.withOpacity(0.8),
                      selectedColor:
                      weatherModel != null
                          ? getThemeColor(
                        weatherModel!.weatherCondition,
                      ).shade200
                          : Colors.blue.shade200,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Weather Display
            Expanded(child: _buildWeatherContent()),

          ],
        ),
      ),
    );
  }

  Widget _buildWeatherContent() {
    if (isLoading == true) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
            SizedBox(height: 20),
            Text(
              'جاري تحميل بيانات الطقس...',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
                const SizedBox(height: 16),
                Text(
                  'حدث خطأ!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  errorMessage!.replaceAll('Exception: ', ''),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (weatherModel == null) {
      return Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wb_sunny, size: 80, color: Colors.orange.shade400),
                const SizedBox(height: 20),
                const Text(
                  'مرحباً بك في تطبيق الطقس! 🌤️',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'ابحث عن أي مدينة لمعرفة حالة الطقس الحالية',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.white.withOpacity(0.8)],
            ),
          ),
          child: Column(
            children: [
              // City Name
              Text(
                weatherModel!.cityName ?? 'غير محدد',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Last Updated
              Text(
                'آخر تحديث: ${weatherModel!.date?.hour.toString().padLeft(2, '0')}:${weatherModel!.date?.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 30),

              // Weather Icon and Temperature
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Weather Icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                      getThemeColor(
                        weatherModel!.weatherCondition,
                      ).shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:
                    weatherModel!.image != null
                        ? Image.network(
                      'https:${weatherModel!.image}',
                      width: 80,
                      height: 80,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.wb_cloudy,
                          size: 80,
                          color: getThemeColor(
                            weatherModel!.weatherCondition,
                          ),
                        );
                      },
                    )
                        : Icon(
                      Icons.wb_cloudy,
                      size: 80,
                      color: getThemeColor(
                        weatherModel!.weatherCondition,
                      ),
                    ),
                  ),

                  // Current Temperature
                  Text(
                    '${weatherModel!.temp?.round()}°',
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color:
                      getThemeColor(
                        weatherModel!.weatherCondition,
                      ).shade700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Weather Condition
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: getThemeColor(weatherModel!.weatherCondition).shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  weatherModel!.weatherCondition ?? 'غير محدد',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: getThemeColor(weatherModel!.weatherCondition).shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              // Min/Max Temperature
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.red.shade400,
                          size: 28,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'أقصى درجة',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        Text(
                          '${weatherModel!.maxTemp?.round()}°',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 1,
                      color: Colors.grey.shade400,
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          color: Colors.blue.shade400,
                          size: 28,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'أقل درجة',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        Text(
                          '${weatherModel!.minTemp?.round()}°',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
