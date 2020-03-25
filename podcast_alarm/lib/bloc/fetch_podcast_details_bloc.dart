import 'dart:async';
import 'package:podcast_alarm/api/api_client.dart';
import 'package:podcast_alarm/data_layer/episode.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'bloc.dart';

class FetchPodcastDetailsBloc implements Bloc {
  final _episodeController = StreamController<List<Episode>>();
  final _podcastDetailsController = StreamController<Podcast>();
  final _client = ApiClient();
  Podcast _podcast;

  Stream<List<Episode>> get episodeStream => _episodeController.stream;
  Stream<Podcast> get podcastStream => _podcastDetailsController.stream;

  void fetchDetailsForPodcast(String podcastId) async {
    try {
      final podcast = await _client.podcastDetails(podcastId);
      _podcastDetailsController.sink.add(podcast);
    } catch (e) {
      _podcastDetailsController.sink.addError(e);
    }
  }

  void fetchEpisodeList(String podcastId) async {
    if (_podcast != null) {
      _episodeController.sink.add(_podcast.episodes.map((json) {
        return Episode.fromJson(json);
      }).toList());
    } else {
      try {
        final podcast = await _client.podcastDetails(podcastId);
        _episodeController.sink.add(podcast.episodes.map((json) {
          return Episode.fromJson(json);
        }).toList());
      } catch (e) {
        _episodeController.sink.addError(e);
      }
    }
  }

  @override
  void dispose() {
    _episodeController.close();
    _podcastDetailsController.close();
  }
}