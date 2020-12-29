import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  final int _value;
  const CounterDisplay(this._value, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_value',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
