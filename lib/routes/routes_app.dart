import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/screens/new_list.dart';

class AppRoutes {
  static const newList = '/newList';

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case newList:
        return MaterialPageRoute(builder: (_) => NewList());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ));
    }
  }
}