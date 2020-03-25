import 'package:flutter/material.dart';
import 'package:podcast_alarm/audio_player/audio_player_widget.dart';
import 'package:podcast_alarm/data_layer/episode.dart';

class AudioPlayerScreen extends StatelessWidget {
  static const routeName = "audio_player_screen";
  static const kPadding = 40;

  @override
  Widget build(BuildContext context) {
    final Episode _episode = ModalRoute.of(context).settings.arguments;
    final imageWidth = MediaQuery.of(context).size.width - (2 * kPadding);
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            SizedBox(height: 20),
            _episodeImage(_episode, imageWidth),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    _episode.title,
                    style: Theme.of(context).textTheme.display1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )),
                ],
              ),
            ),
            AudioPlayerWidget(url: _episode.audio),
          ],
        ));
  }

  _episodeImage(Episode episode, double width) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
        color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(episode.image),
        ),
      ),
    );
  }
}
