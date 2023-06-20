import 'package:flutter/foundation.dart' show immutable;
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_course/src/bloc/api.dart';
import 'package:rxdart_course/src/bloc/search_result.dart';

@immutable
class SearchBloc {
  final Sink<String> search;
  final Stream<SearchResult?> results;
  const SearchBloc._({required this.search, required this.results});

  factory SearchBloc({required Api api}) {
    final textChanges = BehaviorSubject<String>();

    final results = textChanges
        .distinct()
        .debounceTime(const Duration(microseconds: 300))
        .switchMap<SearchResult?>((String searchTerm) {
      if (searchTerm.isEmpty) {
        return Stream<SearchResult?>.value(null);
      } else {
        return Rx.fromCallable(() => api.search(searchTerm))
            .delay(const Duration(seconds: 1))
            .map(
              (results) => results.isEmpty
                  ? const SearchResultNoResult()
                  : SearchResultWithResult(results),
            )
            .startWith(const SearchResultLoading())
            .onErrorReturnWith((error, _) => SearchHasResultError(error));
      }
    });

    return SearchBloc._(search: textChanges.sink, results: results);


  }
}
