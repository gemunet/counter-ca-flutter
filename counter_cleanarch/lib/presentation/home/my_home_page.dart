import 'package:counter/components/counter/presentation/counter_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_viewmodel.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var counterModel = Provider.of<CounterViewModel>(context, listen: false);

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
            Consumer<CounterViewModel>(
              builder: (context, model, child) {
                return ValueListenableBuilder(
                  valueListenable: model.counterValue,
                  builder: (context, value, child) {
                    return CounterDisplay(value);
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
