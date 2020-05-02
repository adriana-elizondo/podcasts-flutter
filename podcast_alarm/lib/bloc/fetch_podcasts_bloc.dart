import 'dart:async';
import 'package:podcast_alarm/api/api_client.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/global/item_tile.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

abstract class Searchable implements Bloc{
  void fetchItems(String query);
  Stream<List<Listable>> get itemStream;
  Future resetOriginalResults();
}

class FetchPodcastsBloc implements Searchable {
  final _controller = BehaviorSubject<List<Podcast>>();
  final _client = ApiClient();
  Future<List<Podcast>> results;

  Stream<List<Podcast>> get podcastStream => _controller.stream;

  void fetchPodcasts(bool fromCache, {String query = "recent"}) async {
    try {
      final results = await _client.fetchPodcasts(query, fromCache);
      _controller.sink.add(results);
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
    results = podcastStream.first;
    this.fetchPodcasts(false, query: query);
  }

  @override
  Stream<List<Listable>> get itemStream {
    return this.podcastStream;
  }

  @override
  resetOriginalResults() async {
    _controller.sink.add(await results);
  }
}