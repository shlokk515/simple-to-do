import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state.
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Flutter Demo Click Counter'),
      ),
      body: Card(
        elevation: 1.0,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(color: Color(0xFF6200EE))),
                  onPressed: () {
                    // Perform some action
                  },
                  child: const Text(
                    'ACTION 1',
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(color: Color(0xFF6200EE))),
                  onPressed: () {
                    // Perform some action
                  },
                  child: const Text('ACTION 2'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
