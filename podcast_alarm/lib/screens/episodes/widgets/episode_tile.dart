import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:podcast_alarm/audio_player/audio_player_bloc.dart';
import 'package:podcast_alarm/audio_player/audio_player_screen.dart';
import 'package:podcast_alarm/bloc/download_bloc.dart';
import 'package:podcast_alarm/data_layer/episode.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/global/circular_percent_indicator.dart';
import 'package:time_formatter/time_formatter.dart';

class EpisodeTile extends StatelessWidget {
  final Podcast podcast;
  final int index;
  final _downloadBloc = DownloadBloc();

  EpisodeTile({@required this.podcast, @required this.index});

  @override
  Widget build(BuildContext context) {
    final Episode _episode = Episode.fromJson(podcast.episodes[index]);
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    _downloadBloc.fileExistsForEpisode(_episode.id);
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
                  ),
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
                  StreamBuilder(
                    stream: _downloadBloc.fileExistsStream,
                    builder: (ctx, snapshot) {
                      if (snapshot.data == null) {
                        return _downloadButton(_episode);
                      }
                      bool exists = snapshot.data;
                      if (exists) {
                        return _downloadedIcon();
                      }
                      return StreamBuilder(
                        stream: _downloadBloc.completionStream,
                        builder: (ctx, snapshot) {
                          if (snapshot.data == null) {
                            return StreamBuilder(
                              stream: _downloadBloc.progressStream,
                              builder: (ctx, snapshot) {
                                if (snapshot.data == null) {
                                  return _downloadButton(_episode);
                                }
                                double progress = snapshot.data;
                                return _progressIndicator(progress, ctx);
                              },
                            );
                          }
                          final filepath = snapshot.data;
                          if (filepath is String) {
                            return _downloadedIcon();
                          }
                          return _errorIcon();
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
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

  _progressIndicator(double progress, BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: CustomPaint(
        foregroundPainter: CircleProgress(progress * 100.0),
        child: Center(
          child: Text((progress * 100.0).toInt().toString(),
              style: Theme.of(context).textTheme.caption),
        ),
      ),
    );
  }

  _downloadButton(Episode episode) {
    return IconButton(
      icon: Icon(
        Icons.arrow_downward,
        color: Colors.white,
      ),
      onPressed: () {
        _downloadFile(episode);
      },
    );
  }

  _downloadedIcon() {
    return Container(
      width: 50,
      height: 50,
      child: Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  _errorIcon() {
    return Container(
      width: 50,
      height: 50,
      child: Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }

  _downloadFile(Episode episode) async {
    _downloadBloc.downloadEpisode(episode.audio, episode.id);
  }
}
