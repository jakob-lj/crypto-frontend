import 'package:flutter/material.dart';
import 'main.dart';

class HomePage extends StatelessWidget{
  static String tag = "home-page";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Loading"), actions: <Widget>[IconButton(icon: Icon(Icons.settings), onPressed: () {_getSettings(context);} )]),
      body:Text("home page")
    );
  }


void _getSettings(BuildContext context) {
    print("gettng settings");
    Navigator.of(context).pushNamed(SettingsScreen.tag);
  }
}