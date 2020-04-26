import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/bloc_provider.dart';
import 'package:podcast_alarm/bloc/fetch_podcast_details_bloc.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/screens/episodes/widgets/episodes_list.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/podcast_info.dart';

class PodcastTabController extends StatefulWidget {
  final Podcast podcast;
  static const routeName = "podcast_tab_controller";

  PodcastTabController({@required this.podcast});

  @override
  _PodcastTabControllerState createState() => _PodcastTabControllerState();
}

class _PodcastTabControllerState extends State<PodcastTabController>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = <Tab>[
    Tab(text: 'Episodes'),
    Tab(text: 'Info'),
  ];
  TabController _tabController;
  final _bloc = FetchPodcastDetailsBloc();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
    _bloc.fetchDetailsForPodcast(widget.podcast.podcast_id);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        controller: _tabController,
        tabs: _tabs,
      ),
      body: BlocProvider<FetchPodcastDetailsBloc>(
        bloc: _bloc,
        child: StreamBuilder<Podcast>(
          stream: _bloc.podcastStream,
          builder: (context, snapshot) {
            if (snapshot.error != null) {
              return Center(child: Text("${snapshot.error}"));
            }
            final results = snapshot.data;
            if (results == null) {
              return Center(child: CircularProgressIndicator());
            }
            return TabBarView(controller: _tabController, children: [
              EpisodesList(podcast: snapshot.data),
              PodcastInfo(podcast: snapshot.data),
            ]);
          },
        ),
      ),
    );
  }
}
