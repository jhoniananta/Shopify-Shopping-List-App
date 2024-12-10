// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/screens/profile_edit_page.dart';
import '../screens/new_list.dart';
import '../screens/home_list_page.dart';
import '../screens/profile_page.dart';
import '../screens/onboarding_page1.dart';
import '../screens/onboarding_page2.dart';
import '../screens/onboarding_page3.dart';
import '../screens/onboarding_page4.dart';
import '../screens/item_list.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  static const newList = '/newList';
  static const home = '/home';
  static const profile = '/profile';
  static const editProfile = '/editProfile';
  static const onBoardingPage1 = '/onBoardingPage1';
  static const onBoardingPage2 = '/onBoardingPage2';
  static const onBoardingPage3 = '/onBoardingPage3';
  static const onBoardingPage4 = '/onBoardingPage4';
  static const itemList = '/itemList';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return PageTransition(
          child: HomeListPage(),
          type: PageTransitionType.fade,
        );
      case newList:
        // return MaterialPageRoute(builder: (_) => NewList());
        return PageTransition(
          child: NewList(),
          type: PageTransitionType.fade,
        );
      case profile:
        // return MaterialPageRoute(builder: (_) => MyProfile());
        return PageTransition(
          child: MyProfile(),
          type: PageTransitionType.fade,
        );
      case editProfile:
        // return MaterialPageRoute(builder: (_) => EditProfile());
        return PageTransition(
          child: EditProfile(),
          type: PageTransitionType.fade,
        );
      case onBoardingPage1:
        return MaterialPageRoute(builder: (_) => OnboardingPage1());
      case onBoardingPage2:
        return PageTransition(
          child: OnboardingPage2(),
          type: PageTransitionType.rightToLeftWithFade,
        );
      case onBoardingPage3:
        return PageTransition(
          child: OnboardingScreen3(),
          type: PageTransitionType.rightToLeftWithFade,
        );
      case onBoardingPage4:
        return PageTransition(
          child: OnboardingScreen4(),
          type: PageTransitionType.rightToLeftWithFade,
        );
      case itemList:
        final args = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ItemList(id: args['id']),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
