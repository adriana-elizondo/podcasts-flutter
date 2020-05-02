import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/genre_details_bloc.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';
import 'package:podcast_alarm/screens/podcasts/widgets/podcast_info.dart';

class PodcastHeaderWidget extends StatelessWidget {
  final Podcast podcast;
  final _genreBloc = GenreDetailsBloc();
  
  PodcastHeaderWidget({@required this.podcast});

  @override
  Widget build(BuildContext context) {
    _genreBloc.getGenresFromIds(podcast.genre_ids);
    final _height = MediaQuery.of(context).size.height / 4;
    return Container(
      height: _height,
      decoration: BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _podcastImage(podcast),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          podcast.podcastTitle ?? podcast.title,
                          style: Theme.of(context).textTheme.subtitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          podcast.podcastPublisher,
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  PodcastInfo(genreStream: _genreBloc.genresStream,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _podcastImage(Podcast podcast) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
        color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(podcast.image),
        ),
      ),
    );
  }
}
