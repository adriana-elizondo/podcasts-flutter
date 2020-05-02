import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/fetch_podcast_details_bloc.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/screens/just_listen/just_listen_screen.dart';

class PodcastCard extends StatelessWidget {
  final Podcast podcast;
  final int kSpacing = 16;

  PodcastCard({@required this.podcast});

  @override
  Widget build(BuildContext context) {
    final _bloc = FetchPodcastDetailsBloc();
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Container(
        height: 160,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(podcast.image),
                  )),
            ),
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(27, 30, 49, 0.45)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    child: Text(
                      podcast.title_original ?? "No title",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subhead,
                      maxLines: 3,
                    ),
                    padding: EdgeInsets.only(right: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          podcast.publisher_original ?? "Anonymous",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle,
                          maxLines: 1,
                        ),
                      ),
                      Material(
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('images/play_button.png'),
                          fit: BoxFit.fill,
                          width: 30.0,
                          height: 30.0,
                          child: InkWell(
                            onTap: () {
                              _bloc.fetchDetailsForPodcast(podcast.id);
                              Navigator.of(context).pushNamed(
                                  JustListenScreen.routeName,
                                  arguments: _bloc.podcastStream);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
