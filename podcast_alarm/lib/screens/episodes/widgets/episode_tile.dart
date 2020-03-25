import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:podcast_alarm/audio_player/audio_player_screen.dart';
import 'package:podcast_alarm/data_layer/episode.dart';
import 'package:podcast_alarm/audio_player/audio_player_widget.dart';

class EpisodeTile extends StatelessWidget {
  final Episode episode;

  EpisodeTile({@required this.episode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Theme(
      data: theme,
      child: ExpansionTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  episode.title,
                  style: Theme.of(context).textTheme.subtitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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
                      Navigator.of(context).pushNamed(AudioPlayerScreen.routeName, arguments: episode);
                    },
                  ),
                ),
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
                        customTextStyle: (node, style) => Theme.of(context).textTheme.caption,
                        data: episode.description,
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
