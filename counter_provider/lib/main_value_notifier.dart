/// uso de ValueNotifier, el modelo crea cada variable como ValueNotifier y
/// reacciona a eventos cada vez que cambia (similar a observable)
/// https://pub.dev/packages/provider

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class CounterModel {
  ValueNotifier<int> counter = ValueNotifier(0);

  void incrementCounter() {
    this.counter.value += 1;
  }
}

// providers: [
//     Provider<Something>(create: (_) => Something()),
//     Provider<SomethingElse>(create: (_) => SomethingElse()),
//     Provider<AnotherThing>(create: (_) => AnotherThing()),
//   ],

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
            Consumer<CounterModel>(
              builder: (context, model, child) {
                return ValueListenableBuilder(
                  valueListenable: model.counter,
                  builder: (context, value, child) {
                    return Text(
                      '$value',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
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
