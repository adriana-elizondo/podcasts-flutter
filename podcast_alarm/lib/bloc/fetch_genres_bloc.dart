import 'dart:async';
import 'package:podcast_alarm/api/api_client.dart';
import 'package:podcast_alarm/bloc/fetch_podcasts_bloc.dart';
import 'package:podcast_alarm/data_layer/genre.dart';
import 'package:podcast_alarm/global/item_tile.dart';
import 'package:rxdart/rxdart.dart';

class FetchGenresBloc implements Searchable {
  final _controller = BehaviorSubject<List<Genre>>();
  final _client = ApiClient();
  Future<List<Genre>> _originalList;

  Stream<List<Genre>> get genreStream => _controller.stream;

  void fetchGenreList() async {
    try {
      final results = await _client.fetchAllGenres();
      _controller.sink.add(results);
    } catch (e) {
      _controller.sink.addError(e);
    }
  }

  void fetchGenresMatching(String query) async {
    try {
      final results = await _client.fetchAllGenres();
      final filteredResults = results.where((genre) => genre.name.toLowerCase().contains(query.toLowerCase())).toList();
      _controller.sink.add(filteredResults);
    } catch (e) {
      _controller.sink.addError(e);
    }
  }

  @override
  void dispose() {
    _controller.close();
  }

  @override
  void fetchItems(String query) {
    _originalList = genreStream.first;
    this.fetchGenresMatching(query);
  }

  @override
  resetOriginalResults() async {
    _controller.sink.add(await _originalList);
  }

  @override
  Stream<List<Listable>> get itemStream {
    return this.genreStream;
  }
}