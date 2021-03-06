import 'package:bloc_state_management/newspage.dart';
import 'package:flutter/material.dart';

import 'counterbloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterBloc = CounterBloc();

  @override
  void dispose() {
    counterBloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
                stream: counterBloc.counterstream,
                initialData: 0,
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventsink.add(CounterAction.Incremet);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventsink.add(CounterAction.Decrement);
            },
            tooltip: 'Increment',
            child: Icon(Icons.keyboard_arrow_down),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventsink.add(CounterAction.reset);
            },
            tooltip: 'Increment',
            child: Icon(Icons.refresh_outlined),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
