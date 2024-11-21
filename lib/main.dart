// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'routes/routes_app.dart';
import '../screens/onboarding_page1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopify List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const OnboardingPage1(),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
