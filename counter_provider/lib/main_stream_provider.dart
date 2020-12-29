/// StreamProvider se consume similar que ChangeNotifierProvider, solo que espera
/// recibir eventos de nuevos modelos inmutables como stream para renderizar
/// Es similar a FutureProvider, pero future solo espera 1 vez
/// https://pub.dev/packages/provider

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class CounterModel extends ChangeNotifier {
  int _counter = 0;

  CounterModel(this._counter);

  int get counter => _counter;
}

Stream<CounterModel> getStreamOfMyModel() {
  return Stream<CounterModel>.periodic(
      Duration(seconds: 1), (x) => CounterModel(x)).take(10);
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
      home: StreamProvider<CounterModel>(
        initialData: CounterModel(0),
        create: (context) => getStreamOfMyModel(),
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
    );
  }
}
