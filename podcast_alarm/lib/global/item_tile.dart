import 'package:flutter/material.dart';
import 'package:podcast_alarm/api/api_client.dart';

abstract class Listable implements Codable {
  String listImageUrl;
  String listName;
}

class ItemTile<L extends Listable> extends StatelessWidget{
  final double _kSpacing = 16;
  final L listItem;

  ItemTile({@required this.listItem});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        height: 130,
        width: screenWidth - 2 * _kSpacing,
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
                  listItem.listImageUrl != null ? Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(listItem.listImageUrl),
                    )),
                  ) : SizedBox(),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      listItem.listName ?? "No title",
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
