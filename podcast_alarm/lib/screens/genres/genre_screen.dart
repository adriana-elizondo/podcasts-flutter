import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/bloc_provider.dart';
import 'package:podcast_alarm/bloc/fetch_genres_bloc.dart';
import 'package:podcast_alarm/data_layer/genre.dart';
import 'package:podcast_alarm/screens/genres/widgets/genre_collection_widget.dart';

class GenreScreen extends StatefulWidget {
  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final bloc = FetchGenresBloc();
  List<Genre> _genreList;

  @override
  void initState() {
    super.initState();
    if (_genreList == null) {
      bloc.fetchGenreList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchGenresBloc>(
      bloc: bloc,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            title: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Search",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
          body: _buildResults(bloc)),
    );
  }

  _buildResults(FetchGenresBloc bloc) {
    return StreamBuilder<List<Genre>>(
      stream: bloc.genreStream,
      builder: (context, snapshot) {
        if (snapshot.error != null) {
          return Center(child: Text("${snapshot.error}"));
        }

        final results = snapshot.data;
        if (results == null) {
          return Center(child: Text('Sory nothing here'));
        }
        if (results.isEmpty) {
          return Center(child: Text('No Results'));
        }
        _genreList = results;
        return GenreCollectionWidget(genreList: results);
      },
    );
  }
}
