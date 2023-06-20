import 'package:flutter/material.dart';
import 'package:rxdart_course/src/bloc/api.dart';
import 'package:rxdart_course/src/bloc/search_bloc.dart';
import 'package:rxdart_course/src/views/search_result_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final SearchBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SearchBloc(api: Api());
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
       body: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [
        TextField(onChanged: _bloc.search.add,), 
        SearchResultView(searchResult: _bloc.results)
      ]),),
    );
  }
}