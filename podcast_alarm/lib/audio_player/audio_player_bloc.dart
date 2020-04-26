import 'package:flutter/cupertino.dart';
import 'package:podcast_alarm/bloc/bloc.dart';
import 'package:podcast_alarm/data_layer/episode.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerBloc implements Bloc {
  final Podcast podcast;
  List<dynamic> _episodes;
  int _currentIndex = 0;
  Subject<Episode> _currentEpisodeStream;
  Stream<Episode> episodeStream;

  AudioPlayerBloc(this.podcast, this._currentIndex) {
    _episodes = podcast.episodes;
    Episode _episode = Episode.fromJson(_episodes[_currentIndex]);
    _currentEpisodeStream = BehaviorSubject<Episode>.seeded(_episode);
    episodeStream = _currentEpisodeStream.stream;
  }

  void previousEpisode()
  {
    if (_currentIndex <= 0) {
      _currentEpisodeStream.addError(FlutterError("No more episodes to show"));
    }
    _currentIndex--;
    _currentEpisodeStream.add(Episode.fromJson(_episodes[_currentIndex]));
  }

  void nextEpisode()
  {
    if (_currentIndex >= _episodes.length) {
      _currentEpisodeStream.addError(FlutterError("No more episodes to show"));
    }
    _currentIndex++;
    _currentEpisodeStream.add(Episode.fromJson( _episodes[_currentIndex]));
  }
  @override
  void dispose() {
    _currentEpisodeStream.close();
  }
}