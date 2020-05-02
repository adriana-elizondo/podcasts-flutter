import 'package:flutter/material.dart';
import 'package:podcast_alarm/data_layer/curated_list.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/global/item_tile.dart';

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
          return ItemTile(listItem: Podcast.fromJson(curatedList.podcasts[index]));
        },
      ),
    );
  }
}
