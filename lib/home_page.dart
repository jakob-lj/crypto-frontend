import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  static String tag = "home-page";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Home")),
      body:Text("home page")
    );
  }
}