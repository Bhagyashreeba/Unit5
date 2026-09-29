import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(SPDarkModeApp());

class SPDarkModeApp extends StatefulWidget {
  @override
  _SPDarkModeAppState createState() => _SPDarkModeAppState();
}

class _SPDarkModeAppState extends State<SPDarkModeApp> {
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDark = prefs.getBool('isDark') ?? false;
    });
  }

  _toggleTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDark = value;
    });
    await prefs.setBool('isDark', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: Text("Dark Mode Toggle")),
        body: Center(
          child: Switch(
            value: _isDark,
            onChanged: _toggleTheme,
          ),
        ),
      ),
    );
  }
}
