import 'package:flutter/material.dart';
import 'package:rxdart_course/src/bloc/search_result.dart';
import 'package:rxdart_course/src/models/animal.dart';
import 'package:rxdart_course/src/models/person.dart';

class SearchResultView extends StatelessWidget {
  final Stream<SearchResult?> searchResult;
  const SearchResultView({super.key, required this.searchResult});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchResult?>(
        stream: searchResult,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final result = snapshot.data;
            if (result is SearchHasResultError) {
              return const Text("Error on Searching...");
            } else if (result is SearchResultLoading) {
              return const CircularProgressIndicator();
            } else if (result is SearchResultNoResult) {
              return const Text("Not Found");
            } else if (result is SearchResultWithResult) {
              final results = result.results;
              return Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: ((context, index) {
                    final item = results[index];
                    final String title;
                    if (item is Animal) {
                      title = "Animal";
                    } else if (item is Person) {
                      title = "Person";
                    } else {
                      title = "Unknown";
                    }
                    return ListTile(
                      title: Text(title),
                      subtitle: Text(item.toString()),
                    );
                  }),
                ),
              );
            }else{
              return const Text("Unknow State!");
            }
          } else {
            return const Text("Waiting");
          }
        });
  }
}
