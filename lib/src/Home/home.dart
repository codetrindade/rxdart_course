import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final BehaviorSubject<String> subject;

  @override
  void initState() {
    super.initState();
    subject = BehaviorSubject<String>();
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key("appBarHome"),
        title:  StreamBuilder<String>(
          stream: subject.stream,
          builder: (context, snapshot) {
            return Text(snapshot.data.toString() ?? '');
          }
        ),
      ),
      body: SafeArea(
          child: Center(
        child: TextField(
          onChanged: (value) => subject.sink.add(value),
        ),
      )),
    );
  }
}
