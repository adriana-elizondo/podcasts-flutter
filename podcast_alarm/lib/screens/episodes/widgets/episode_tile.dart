import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:podcast_alarm/audio_player/audio_player_bloc.dart';
import 'package:podcast_alarm/audio_player/audio_player_screen.dart';
import 'package:podcast_alarm/data_layer/episode.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:time_formatter/time_formatter.dart';

class EpisodeTile extends StatelessWidget {
  final Podcast podcast;
  final int index;

  EpisodeTile({@required this.podcast, @required this.index});

  @override
  Widget build(BuildContext context) {
    final Episode _episode = Episode.fromJson(podcast.episodes[index]);
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Theme(
      data: theme,
      child: ExpansionTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      formatTime(_episode.pub_date_ms),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _episode.title,
                      style: Theme.of(context).textTheme.subtitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(width: 20),
                  Material(
                    shape: CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink.image(
                      image: AssetImage('images/play_button.png'),
                      fit: BoxFit.cover,
                      width: 25.0,
                      height: 25.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              AudioPlayerScreen.routeName,
                              arguments: AudioPlayerBloc(podcast, index));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Html(
                        customTextStyle: (node, style) =>
                            Theme.of(context).textTheme.caption,
                        data: _episode.description,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
