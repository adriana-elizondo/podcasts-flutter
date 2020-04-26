import 'dart:async';
import 'package:podcast_alarm/api/api_client.dart';
import 'package:podcast_alarm/data_layer/curated_list.dart';
import 'bloc.dart';

class FetchCuratedBloc implements Bloc {
  final _controller = StreamController<List<CuratedList>>();
  final _client = ApiClient();

  Stream<List<CuratedList>> get curatedListStream => _controller.stream;

  void fetchCuratedLists() async {
    try {
      final results = await _client.fetchCuratedPodcasts();
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