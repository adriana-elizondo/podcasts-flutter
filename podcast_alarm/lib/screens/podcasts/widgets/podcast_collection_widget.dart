import 'package:flutter/material.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/podcast_card.dart';

class PodcastCollectionWidget extends StatelessWidget {
  final List<Podcast> podcastList;
  final double _kSpacing = 16;

  PodcastCollectionWidget({@required this.podcastList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text("Recently updated podcasts",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline6),
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: <Widget>[
            Wrap(
                runSpacing: _kSpacing,
                spacing: _kSpacing,
                children: podcastList.map((podcast) {
                  return PodcastCard(podcast: podcast);
                }).toList()),
          ]),
        ),
      ],
    );
  }
}
