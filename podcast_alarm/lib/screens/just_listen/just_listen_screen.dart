import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/bloc_provider.dart';
import 'package:podcast_alarm/bloc/just_listen_bloc.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/podcast_tab_controller.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/podcast_header_widget.dart';

class JustListenScreen extends StatefulWidget {
  @override
  _JustListenScreenState createState() => _JustListenScreenState();
}

class _JustListenScreenState extends State<JustListenScreen> {
  final bloc = JustListenBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchRandomPodcast();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JustListenBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          elevation: 0,
        ),
        body: StreamBuilder<Podcast>(
          stream: bloc.randomPodcastStream,
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
      ),
    );
  }
}
