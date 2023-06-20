import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override 
  Widget build(BuildContext context) {
    //Create
    final subject = useMemoized(()=> BehaviorSubject<String>(), [key]);
    //Dispose
    useEffect(() => subject.close, [subject]);
    return Scaffold(
      appBar: AppBar(
        key: const Key("appBarHome"),
        title:  StreamBuilder<String>(
          stream: subject.stream.distinct().debounceTime(const Duration(milliseconds: 150)),
          builder: (context, snapshot) {
            return Text(snapshot.data.toString());
          }
        ),
      ),
      body: SafeArea(
          child: Center(
        child: TextField(
          onChanged: subject.sink.add,
        ),
      )),
    );
  }
}
