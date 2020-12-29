/// Demostracion de uso de ChangeNotifierProvider dentro de Build
/// https://pub.dev/packages/provider

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class CounterModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    this._counter++;
    notifyListeners();
  }
}

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterModel(),
      builder: (context, child) {
        var counterModel = Provider.of<CounterModel>(context, listen: false);

        return Scaffold(
          appBar: AppBar(
            title: Text(this.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times: \n${DateTime.now()}',
                ),
                Consumer<CounterModel>(
                  builder: (context, model, child) {
                    return Text(
                      '${model.counter}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              counterModel.incrementCounter();
              print("increment");
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
