import 'package:flutter/material.dart';
import 'package:calculator/Scientific_cal.dart';
import 'package:calculator/simple_cal.dart';

void main() {
  runApp(MaterialApp(
    home: CalculatorView(),
    routes: {
      '/simpleCal': (context) => CalculatorView(),
      '/scientificCal' : (context) => Scientific_calculator(),
    },
  ));
}





