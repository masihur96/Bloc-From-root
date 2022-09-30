import 'dart:async';

enum CounterAction { increment, decrement, reset }

class CounterBloc {
  int counter = 0;

  //State Stream Controlling
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get counterStateSink => _stateStreamController.sink;
  Stream<int> get counterStateStream => _stateStreamController.stream;

  //Even Stream Controlling
  final _evenStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get counterEvenSink => _evenStreamController.sink;
  Stream<CounterAction> get counterEvenStream => _evenStreamController.stream;

  CounterBloc() {
    counterEvenStream.listen((event) {
      if (event == CounterAction.increment) {
        counter++;
      } else if (event == CounterAction.decrement) {
        counter--;
      } else if (event == CounterAction.reset) {
        counter = 0;
      }
      counterStateSink.add(counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _evenStreamController.close();
  }
}
