import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/fetch_podcast_details_bloc.dart';
import 'package:podcast_alarm/data_layer/curated_list.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/screens/just_listen/just_listen_screen.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/podcast_tab_controller.dart';

class PodcastListScreen extends StatelessWidget {
  final CuratedList curatedList;
  final int kSpacing = 16;
  static const routeName = "podcast_list_screen";

  PodcastListScreen({@required this.curatedList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(curatedList.title, style: Theme.of(context).textTheme.headline6,),
      ),
      body: ListView.builder(
        itemCount: curatedList.podcasts.length,
        itemBuilder: (ctx, index) {
          return _podcastTile(ctx, Podcast.fromJson(curatedList.podcasts[index]));
        },
      ),
    );
  }

  _podcastTile(BuildContext context, Podcast podcast) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        final _bloc = FetchPodcastDetailsBloc();
        _bloc.fetchDetailsForPodcast(podcast.id);
        Navigator.of(context).pushNamed(
            JustListenScreen.routeName,
            arguments: _bloc.podcastStream);
      },
      child: Container(
        height: 130,
        width: screenWidth - 2 * kSpacing,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(podcast.image),
                    )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      podcast.title ?? "No title",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
