import 'package:flutter/material.dart';
import 'package:podcast_alarm/data_layer/genre.dart';

class PodcastInfo extends StatelessWidget {
  final Stream<List<Genre>> genreStream;
  PodcastInfo({@required this.genreStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Genre>>(
      stream: genreStream,
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
    );
  }
}