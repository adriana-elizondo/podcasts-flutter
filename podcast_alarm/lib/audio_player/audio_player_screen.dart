import 'package:flutter/material.dart';
import 'package:podcast_alarm/audio_player/audio_player_bloc.dart';
import 'package:podcast_alarm/audio_player/audio_player_widget.dart';
import 'package:podcast_alarm/bloc/bloc_provider.dart';
import 'package:podcast_alarm/data_layer/episode.dart';

class AudioPlayerScreen extends StatelessWidget {
  static const routeName = "audio_player_screen";
  static const kPadding = 40;
  final AudioPlayerBloc bloc;

  AudioPlayerScreen({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width - (2 * kPadding);
    return BlocProvider<AudioPlayerBloc>(
        bloc: bloc,
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: StreamBuilder<Episode>(
              stream: bloc.episodeStream,
              builder: (context, snapshot) {
                if (snapshot.error != null) {
                  return Center(child: Text("${snapshot.error}"));
                }
                final results = snapshot.data;
                if (results == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    _episodeImage(snapshot.data, imageWidth),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  snapshot.data.title,
                                  style: Theme.of(context).textTheme.display1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AudioPlayerWidget(
                      audioPlayerBloc: bloc,
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }

  _episodeImage(Episode episode, double width) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2,
          ),
        ],
        color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(episode.image),
        ),
      ),
    );
  }
}
