import 'package:flutter/material.dart';
import 'package:podcast_alarm/bloc/bloc_provider.dart';
import 'package:podcast_alarm/bloc/just_listen_bloc.dart';
import 'package:podcast_alarm/screens/genres/genre_screen.dart';
import 'package:podcast_alarm/screens/just_listen/just_listen_screen.dart';
import 'package:podcast_alarm/screens/podcasts/search_podcasts_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Widget> _tabItems;
  final _bloc = JustListenBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetchRandomPodcast();

    _tabItems = [
      SearchPodcastScreen(),
      GenreScreen(),
      BlocProvider<JustListenBloc>(
        bloc: _bloc,
        child: JustListenScreen(podcastStream: _bloc.randomPodcastStream,),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).primaryColor;
    final disabledColor = Color(0xFF8F9FB3);
    return Scaffold(
      body: _tabItems[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.white,
        unselectedItemColor: disabledColor,
        currentIndex: _currentIndex,
        onTap: _tabItemSelected,
        items: [
          BottomNavigationBarItem(
            backgroundColor: backgroundColor,
            icon: Icon(Icons.search),
            title: Text("Podcasts"),
          ),
          BottomNavigationBarItem(
            backgroundColor: backgroundColor,
            icon: Icon(Icons.category),
            title: Text("Genres"),
          ),
          BottomNavigationBarItem(
            backgroundColor: backgroundColor,
            icon: Icon(Icons.play_circle_outline),
            title: Text("Just Listen"),
          )
        ],
      ),
    );
  }

  _tabItemSelected(int itemIndex) {
    setState(() {
      _currentIndex = itemIndex;
    });
  }
}
