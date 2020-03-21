import 'dart:async';
import 'package:podcast_alarm/api/api_client.dart';
import 'package:podcast_alarm/data_layer/genre.dart';
import 'bloc.dart';

class FetchGenresBloc implements Bloc {
  final _controller = StreamController<List<Genre>>();
  final _client = ApiClient();

  Stream<List<Genre>> get genreStream => _controller.stream;

  void fetchGenreList() async {
    try {
      final results = await _client.fetchAllGenres();
      _controller.sink.add(results);
    } catch (e) {
      _controller.sink.addError(e);
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}