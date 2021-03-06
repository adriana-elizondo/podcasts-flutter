import 'package:podcast_alarm/api/api_client.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class JustListenBloc implements Bloc {
  final _controller = BehaviorSubject<Podcast>();
  final _client = ApiClient();

  BehaviorSubject<Podcast> get randomPodcastStream => _controller.stream;

  void fetchRandomPodcast() async {
    try {
      final results = await _client.fetchRandomPodcast();
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