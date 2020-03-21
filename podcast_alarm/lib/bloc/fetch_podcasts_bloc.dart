import 'dart:async';
import 'package:podcast_alarm/api/api_client.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'bloc.dart';

class FetchPodcastsBloc implements Bloc {
  final _controller = StreamController<List<Podcast>>();
  final _client = ApiClient();

  Stream<List<Podcast>> get podcastStream => _controller.stream;

  void fetchPodcasts({String query = "recent"}) async {
    try {
      final results = await _client.fetchPodcasts(query);
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