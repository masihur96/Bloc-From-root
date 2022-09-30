import 'package:flutter/material.dart';

import 'counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
              stream: counterBloc.counterStateStream,
              initialData: 0,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.counterEvenSink.add(CounterAction.increment);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FloatingActionButton(
              onPressed: () {
                counterBloc.counterEvenSink.add(CounterAction.decrement);
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.counterEvenSink.add(CounterAction.reset);
            },
            tooltip: 'Reset',
            child: const Icon(Icons.loop),
          ),
        ],
      ),
    );
  }
}
