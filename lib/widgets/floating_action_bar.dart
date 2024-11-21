// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/newList');
      },
      backgroundColor: Colors.grey.withOpacity(0.4),
      elevation: 0,
      shape: CircleBorder(),
      child: Icon(
        Icons.add,
        color: Colors.purple, 
        size: 28,
      ),
    );
  }
}