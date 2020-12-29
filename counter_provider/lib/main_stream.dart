import 'dart:async';

/// ChangeNotifierProvider
/// https://pub.dev/packages/provider

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class CounterModel {
  int _counter = 0;

  StreamController<int> _counterController = StreamController();
  Stream<int> get counterStream => _counterController.stream;

  void incrementCounter() {
    this._counterController.sink.add(this._counter++);
  }

  // FIXME: siempre debe ser llamada para cerrar el controller
  // StreamBuilder invoca al close() del stream, creo que eso es suficiente
  // void dispose() {
  //   _counterController.close();
  // }
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
      home: Provider(
        create: (context) => CounterModel(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
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
            StreamBuilder<int>(
              stream: counterModel.counterStream,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
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
  }
}
