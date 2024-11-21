// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/screens/home_list_page.dart';
import 'package:shopify_shopping_list_app/screens/new_list.dart';
import 'package:shopify_shopping_list_app/screens/onboarding_3.dart';
import 'package:shopify_shopping_list_app/screens/onboarding_4.dart';
import 'package:shopify_shopping_list_app/screens/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OnboardingScreen4(),
    );
  }
}
