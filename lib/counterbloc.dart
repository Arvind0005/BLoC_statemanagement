import 'dart:async';

enum CounterAction {
  Incremet,
  Decrement,
  reset,
}

class CounterBloc {
  int counter;
  // ignore: non_constant_identifier_names
  final _StateStreamController = StreamController<int>();
  StreamSink<int> get countersink => _StateStreamController.sink;
  Stream<int> get counterstream => _StateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventsink => _eventStreamController.sink;
  Stream<CounterAction> get eventstream => _eventStreamController.stream;

  CounterBloc() {
    counter = 0;
    eventstream.listen((event) {
      print("yes");
      if (event == CounterAction.Incremet)
        counter++;
      else if (event == CounterAction.Decrement)
        counter--;
      else if (event == CounterAction.reset) counter = 0;
      countersink.add(counter);
    });
  }
  void dispose() {
    _StateStreamController.close();
    _eventStreamController.close();
  }
}
