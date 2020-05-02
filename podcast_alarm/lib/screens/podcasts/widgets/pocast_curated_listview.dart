import 'package:flutter/material.dart';
import 'package:podcast_alarm/data_layer/curated_list.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/screens/podcasts/podcast_list_screen.dart';
import 'package:time_formatter/time_formatter.dart';

class CuratedPocastsList extends StatelessWidget {
  final List<CuratedList> curatedList;
  final int kSpacing = 16;

  CuratedPocastsList({@required this.curatedList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: curatedList.length,
      itemBuilder: (ctx, index) {
        return _curatedCard(ctx, curatedList[index]);
      },
    );
  }

  _curatedCard(BuildContext context, CuratedList list) {
    final screenWidth = MediaQuery.of(context).size.width;
    final podcast = Podcast.fromJson(list.podcasts.first);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
            PodcastListScreen.routeName,
            arguments: list);
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
                children: <Widget>[
                  Expanded(
                    child: Text(
                      formatTime(list.pub_date_ms),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )
                ],
              ),
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
                      list.title ?? "No title",
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
