import 'package:flutter/material.dart';
import 'package:podcast_alarm/screens/genres/genre_screen.dart';
import 'package:podcast_alarm/screens/podcasts/search_podcasts_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Widget> _tabItems;

  @override
  void initState() {
    super.initState();
    _tabItems = [SearchPodcastScreen(), GenreScreen()];
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
            icon: Icon(Icons.search),
            title: Text("Search"),
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
