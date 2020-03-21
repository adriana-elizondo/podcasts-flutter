import 'package:flutter/material.dart';
import 'package:podcast_alarm/api/api_client.dart';
import 'package:podcast_alarm/screens/main_screen.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    ApiClient.sharedInstance.setupApiClient(proxy: "192.168.8.155:8888");
  }

  @override
  void dispose() {
    ApiClient.sharedInstance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData(
      backgroundColor: Color(0xFF1b1e31),
      scaffoldBackgroundColor: Color(0xFF1b1e31),
      disabledColor: Color(0x664795D6),
      accentColor: Color(0xFF3023AE),
      primaryColor: Color(0xFF1b1e31),
      secondaryHeaderColor: Color(0x26009EE8),
      errorColor: Color(0xFFD1334A),
      cursorColor: Color(0xFF3023AE),
      cardColor: Color(0xFFE9EBF4),
      hintColor: Color(0xFF4C5F6B),
      dividerColor: Color(0xFFEFEFEF),
      highlightColor: Colors.transparent,
      textTheme: TextTheme(
        display1: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        display2: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        headline: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        subhead: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        subtitle: TextStyle(fontSize: 18, color: Colors.white),
        title: TextStyle(fontSize: 18, color: Colors.white),
        button: TextStyle(fontSize: 16, color: Colors.white),
        caption: TextStyle(fontSize: 14, color: Colors.white),
        body1: TextStyle(fontSize: 16, color: Colors.white),
        body2: TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
    return MaterialApp(
      title: 'Best alarm ever',
      theme: theme,
      home: MainScreen(),
    );
  }
}