import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final amountNumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountNumController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    amountNumController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    // ignore: avoid_print
    print('Second text field: ${amountNumController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Click Counter'),
      ),
      body: Card(
        elevation: 1.0,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: amountNumController,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
