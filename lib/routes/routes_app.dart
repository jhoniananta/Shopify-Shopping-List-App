// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../screens/new_list.dart';
import '../screens/home_list_page.dart';
import '../screens/profile_page.dart';
import '../screens/onboarding_page1.dart';
import '../screens/onboarding_page2.dart';
import '../screens/onboarding_page3.dart';
import '../screens/onboarding_page4.dart';


class AppRoutes {
  static const newList = '/newList';
  static const home = '/home';
  static const profile = '/profile';
  static const onBoardingPage1 = '/onBoardingPage1';
  static const onBoardingPage2 = '/onBoardingPage2';
  static const onBoardingPage3 = '/onBoardingPage3';
  static const onBoardingPage4 = '/onBoardingPage4';

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case home:
        return MaterialPageRoute(builder: (_) => HomeListPage());
      case newList:
        return MaterialPageRoute(builder: (_) => NewList());
      case profile:
        return MaterialPageRoute(builder: (_) => MyProfile());
      case onBoardingPage1:
        return MaterialPageRoute(builder: (_) => OnboardingPage1());
      case onBoardingPage2:
        return MaterialPageRoute(builder: (_) => OnboardingPage2());
      case onBoardingPage3:
        return MaterialPageRoute(builder: (_) => OnboardingScreen3());
      case onBoardingPage4:
        return MaterialPageRoute(builder: (_) => OnboardingScreen4());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ));
    }
  }
}