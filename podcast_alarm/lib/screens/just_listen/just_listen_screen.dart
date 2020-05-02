import 'package:flutter/material.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/podcast_tab_controller.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/podcast_header_widget.dart';

class JustListenScreen extends StatelessWidget {
  static const routeName = "just_listen_screen";
  final Stream<Podcast> podcastStream;

  JustListenScreen({@required this.podcastStream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .secondaryHeaderColor,
        elevation: 0,
      ),
      body: StreamBuilder<Podcast>(
        stream: podcastStream,
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            return Center(child: Text("${snapshot.error}"));
          }

          final podcast = snapshot.data;
          if (podcast == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              PodcastHeaderWidget(
                podcast: podcast,
              ),
              Expanded(
                child: PodcastTabController(
                  podcast: snapshot.data,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}