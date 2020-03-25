import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/bloc_provider.dart';
import 'package:podcast_alarm/bloc/fetch_podcast_details_bloc.dart';
import 'package:podcast_alarm/data_layer/episode.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/screens/episodes/widgets/episode_tile.dart';

class EpisodesList extends StatelessWidget {
  final Podcast podcast;

  EpisodesList({@required this.podcast});

  @override
  Widget build(BuildContext context) {
    final _episodeList = podcast.episodes.map((json) { return Episode.fromJson(json); }).toList();
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2B2F48),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView.separated(
            separatorBuilder: (context, index) => Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Divider(),
            ),
            itemCount: _episodeList.length,
            itemBuilder: (context, index) {
              return EpisodeTile(episode: _episodeList[index]);
            }),
      ),
    );
  }
}
