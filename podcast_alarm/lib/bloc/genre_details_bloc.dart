import 'dart:async';
import 'package:podcast_alarm/api/api_client.dart';
import 'package:podcast_alarm/bloc/bloc.dart';
import 'package:podcast_alarm/data_layer/genre.dart';
import 'package:rxdart/rxdart.dart';

class GenreDetailsBloc implements Bloc {
  final _controller = BehaviorSubject<List<Genre>>();

  Stream<List<Genre>> get genresStream => _controller.stream;
  final _client = ApiClient();

  void getGenresFromIds(List<int> genreIds) async {
    try {
      final genreList = await _client.fetchAllGenres();
      List<Genre> genres = genreList.where((element) => genreIds.contains(element.id)).toList();
      _controller.sink.add(genres);
    } catch (e) {
      _controller.sink.addError(e);
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
