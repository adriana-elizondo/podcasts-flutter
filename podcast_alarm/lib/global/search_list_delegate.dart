import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/fetch_podcasts_bloc.dart';
import 'package:podcast_alarm/global/item_tile.dart';

class SearchListDelegate extends SearchDelegate {
  final Searchable bloc;
  SearchListDelegate(this.bloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        bloc.resetOriginalResults();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    bloc.fetchItems(query);
    return StreamBuilder<List<Listable>>(
      stream: bloc.itemStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          );
        } else if (snapshot.data.length == 0) {
          return Column(
            children: <Widget>[
              Text(
                "No Results Found.",
              ),
            ],
          );
        } else {
          var results = snapshot.data;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              var item = results[index];
              return ItemTile(listItem: item);
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("$query");
  }
}
