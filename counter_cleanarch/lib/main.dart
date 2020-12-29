import 'package:counter/presentation/app.dart';
import 'package:counter/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}
