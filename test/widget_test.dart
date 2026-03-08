import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app2/main.dart';

void main() {
  group('Weather App Tests', () {
    testWidgets('App should display welcome message when no weather data', (
        WidgetTester tester,
        ) async {
      await tester.pumpWidget(const WeatherApp());

      expect(find.text('مرحباً بك في تطبيق الطقس! 🌤️'), findsOneWidget);
      expect(
        find.text('ابحث عن أي مدينة لمعرفة حالة الطقس الحالية'),
        findsOneWidget,
      );
    });

    testWidgets('Search field should be present', (WidgetTester tester) async {
      await tester.pumpWidget(const WeatherApp());

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('أدخل اسم المدينة'), findsOneWidget);
    });

    testWidgets('Search button should be present', (WidgetTester tester) async {
      await tester.pumpWidget(const WeatherApp());

      expect(find.text('بحث عن الطقس'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('City chips should be displayed', (WidgetTester tester) async {
      await tester.pumpWidget(const WeatherApp());

      expect(find.byType(FilterChip), findsWidgets);
      expect(find.text('Riyadh'), findsOneWidget);
      expect(find.text('Jeddah'), findsOneWidget);
    });

    testWidgets('App bar should display correct title', (
        WidgetTester tester,
        ) async {
      await tester.pumpWidget(const WeatherApp());

      expect(find.text('تطبيق الطقس'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}