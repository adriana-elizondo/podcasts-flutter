import 'package:flutter/material.dart';
import 'package:podcast_alarm/data_layer/genre.dart';
import 'package:podcast_alarm/global/ui_extensions.dart';

class GenreWidget extends StatelessWidget {
  final Genre genre;

  GenreWidget({@required this.genre});

  @override
  Widget build(BuildContext context) {
    final Size _size = Size(MediaQuery.of(context).size.width / 2 - 44, 100);
    return Stack(
      children: <Widget>[
        Container(
          height: _size.height,
          width: _size.width,
          decoration: BoxDecoration(
            color: RandomColor.getNewColor(),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Container(
          height: _size.height,
          width: _size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(27, 30, 49, 0.45)),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                genre.name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
