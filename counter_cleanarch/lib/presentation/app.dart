import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/counter_viewmodel.dart';
import 'home/my_home_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Provider(
        create: (context) => CounterViewModel(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
