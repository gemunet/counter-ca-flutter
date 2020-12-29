import 'dart:async';

/// BLOC
/// El stream puede ser cualquier tipo de clase para indicar "Loading/Error/Data"
/// el dispose() se invoca automaticamente y cierra el controller
/// http://xurxodev.com/el-patron-bloc-junto-a-clean-architecture-en-flutter/
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// clase base
abstract class Bloc<T> {
  final _stateController = StreamController<T>.broadcast();
  T _state;

  T get state => _state;
  Stream<T> get observableState => _stateController.stream;

  @protected
  void changeState(T state) {
    _state = state;
    _stateController.sink.add(state);
  }

  void dispose() {
    _stateController.close();
  }
}

// custom provider
class BlocProvider<T extends Bloc> extends StatefulWidget {
  const BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }
}

class _BlocProviderState<T> extends State<BlocProvider<Bloc>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// modelo
class CounterModel extends Bloc<int> {
  int _counter = 0;

  CounterModel() {
    this.changeState(this._counter);
  }

  void incrementCounter() {
    this.changeState(++this._counter);
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
      home: BlocProvider<CounterModel>(
        bloc: new CounterModel(),
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
    final counterModel = BlocProvider.of<CounterModel>(context);

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
              initialData: counterModel.state,
              stream: counterModel.observableState,
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
