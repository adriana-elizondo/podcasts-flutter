import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/bloc_provider.dart';
import 'package:podcast_alarm/bloc/fetch_podcasts_bloc.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/global/polygon_painter.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/podcast_collection_widget.dart';

class SearchPodcastScreen extends StatefulWidget {
  @override
  _SearchPodcastScreenState createState() => _SearchPodcastScreenState();
}

class _SearchPodcastScreenState extends State<SearchPodcastScreen> {
  final bloc = FetchPodcastsBloc();
  List<Podcast> _podcastList;

  @override
  void initState() {
    super.initState();
    if (_podcastList == null) {
      bloc.fetchPodcasts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchPodcastsBloc>(
      bloc: bloc,
      child: _buildResults(bloc),
    );
  }

  _buildResults(FetchPodcastsBloc bloc) {
    return StreamBuilder<List<Podcast>>(
      stream: bloc.podcastStream,
      builder: (context, snapshot) {
        if (snapshot.error != null) {
          return Center(child: Text("${snapshot.error}"));
        }

        final results = snapshot.data;
        if (results == null) {
          return Center(child: Text('Sory nothing here'));
        }
        if (results.isEmpty) {
          return Center(child: Text('No Results'));
        }
        return _searchScreenBackground(snapshot.data);
      },
    );
  }

  _searchScreenBackground(List<Podcast> podcastList) {
    _podcastList = podcastList;
    return Stack(
      children: <Widget>[
        Container(
          child: CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: PolygonPainter(),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            title: Text("Explore"),
          ),
          body: PodcastCollectionWidget(podcastList: podcastList),
        ),
      ],
    );
  }
}
