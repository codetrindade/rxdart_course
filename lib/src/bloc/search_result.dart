
import 'package:flutter/foundation.dart' show immutable;
import 'package:rxdart_course/src/models/thing.dart';



@immutable abstract class SearchResult{
  const SearchResult();
}

@immutable class SearchResultLoading implements SearchResult {
  const SearchResultLoading();
}


@immutable class SearchResultNoResult implements SearchResult {
  const SearchResultNoResult();
}
@immutable class SearchHasResultError implements SearchResult{
  final Object error;
  const SearchHasResultError(this.error);
}

@immutable class SearchResultWithResult implements SearchResult{
  final List<Thing> results;

  const SearchResultWithResult(this.results);
  

}