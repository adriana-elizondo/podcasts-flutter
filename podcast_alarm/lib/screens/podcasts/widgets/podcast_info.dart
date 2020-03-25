import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/bloc_provider.dart';
import 'package:podcast_alarm/bloc/genre_details_bloc.dart';
import 'package:podcast_alarm/data_layer/genre.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';

class PodcastInfo extends StatefulWidget {
  final Podcast podcast;

  PodcastInfo({@required this.podcast});

  @override
  _PodcastInfoState createState() => _PodcastInfoState();
}

class _PodcastInfoState extends State<PodcastInfo> {
  final _bloc = GenreDetailsBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getGenresFromIds(widget.podcast.genre_ids);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GenreDetailsBloc>(
      bloc: _bloc,
      child: StreamBuilder<List<Genre>>(
        stream: _bloc.genresStream,
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
          return Column(
            children: results.map((genre) {
                return Text(genre.name);
              }).toList(),
          );
        },
      ),
    );
  }
}
