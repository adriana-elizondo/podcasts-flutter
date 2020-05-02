import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/bloc_provider.dart';
import 'package:podcast_alarm/bloc/fetch_curated_bloc.dart';
import 'package:podcast_alarm/bloc/fetch_podcasts_bloc.dart';
import 'package:podcast_alarm/data_layer/curated_list.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/global/polygon_painter.dart';
import 'package:podcast_alarm/global/search_list_delegate.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/pocast_curated_listview.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/podcast_collection_widget.dart';

class SearchPodcastScreen extends StatefulWidget {
  @override
  _SearchPodcastScreenState createState() => _SearchPodcastScreenState();
}

class _SearchPodcastScreenState extends State<SearchPodcastScreen> {
  final _fetchPodcastsBloc = FetchPodcastsBloc();
  final _fetchCuratedListsBloc = FetchCuratedBloc();

  @override
  void initState() {
    super.initState();
    _fetchPodcastsBloc.fetchPodcasts(true);
    _fetchCuratedListsBloc.fetchCuratedLists();
  }

  @override
  Widget build(BuildContext context) {
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
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: SearchListDelegate(_fetchPodcastsBloc),
                      );
                    },
                    child: Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  )),
            ],
            title: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Explore",
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
          body: Column(
            children: [
              BlocProvider<FetchPodcastsBloc>(
                bloc: _fetchPodcastsBloc,
                child: StreamBuilder<List<Podcast>>(
                  stream: _fetchPodcastsBloc.podcastStream,
                  builder: (context, snapshot) {
                    if (snapshot.error != null) {
                      return Center(child: Text("${snapshot.error}"));
                    }

                    final results = snapshot.data;
                    if (results == null) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (results.isEmpty) {
                      return Center(child: Text('No Results'));
                    }
                    return PodcastCollectionWidget(podcastList: snapshot.data);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Recommended for you",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
              BlocProvider<FetchCuratedBloc>(
                bloc: _fetchCuratedListsBloc,
                child: StreamBuilder<List<CuratedList>>(
                  stream: _fetchCuratedListsBloc.curatedListStream,
                  builder: (context, snapshot) {
                    if (snapshot.error != null) {
                      return Center(child: Text("${snapshot.error}"));
                    }

                    final results = snapshot.data;
                    if (results == null) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (results.isEmpty) {
                      return Center(child: Text('No Results'));
                    }
                    return Expanded(
                      child: CuratedPocastsList(curatedList: snapshot.data),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
