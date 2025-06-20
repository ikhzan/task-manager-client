import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';

class AppRoute {
  
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => HomeScreen(),
  };
  
}