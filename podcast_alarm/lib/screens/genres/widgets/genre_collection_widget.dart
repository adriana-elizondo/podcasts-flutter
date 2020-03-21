import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podcast_alarm/data_layer/genre.dart';

import 'genre_widget.dart';

class GenreCollectionWidget extends StatelessWidget {
  final List<Genre> genreList;
  final double _kSpacing = 16;

  GenreCollectionWidget({@required this.genreList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Browse all genres",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ],),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16),
            child: Wrap(
                runSpacing: _kSpacing,
                spacing: _kSpacing,
                children: genreList.map((genre) {
                  return GenreWidget(genre: genre);
                }).toList()),
          )
        ],
      ),
    );
  }
}
