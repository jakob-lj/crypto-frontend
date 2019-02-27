import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'backend.dart';
import 'auth.dart';
import 'user.dart';
import 'crypto_peer.dart';
import 'start_page.dart';
import 'dart:convert';
import 'websockets.dart';

//void main() => runApp(Monica());


class Monica extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    LoginPage.tag: (context) => LoginPage(),
    SettingsScreen.tag: (context) => SettingsScreen()
  };

  Widget build(BuildContext context) {

    Backend.init();

    //for testing
    //getUserData();

    //CryptoPeer.ss();
    CryptoPeer.c();

    return MaterialApp(
      title:("Hakon"),
      home: LoadingPage(),
      routes: routes
    );
  }

  Future<User> getUserData() async {
    Auth auth = Auth.getInstance();
    var user = await auth.signInByEmail("jake", "jake");
    return user;
  }
}

class LoadingPage extends StatelessWidget {

  Future<User> getUser() async {
    Auth auth = Auth.getInstance();
    return await auth.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {

    getUser().then( (user) {
      if (user != null) {
        print("logged in");
        print(HomePage());
        Navigator.of(context).pushReplacementNamed(HomePage.tag);
      } else {
        print("logged out");
        print(LoginPage());
        Navigator.of(context).pushReplacementNamed(LoginPage.tag);
      }
    });

    Widget g = Scaffold(
        appBar: AppBar(title: Text("Loading"), actions: <Widget>[IconButton(icon: Icon(Icons.settings), onPressed: () {_getSettings(context);} )]),
      body: Center(child:CircularProgressIndicator())
    );
    return g;
  }


  void _getSettings(BuildContext context) {
    print("gettng settings");
    Navigator.of(context).pushNamed(SettingsScreen.tag);
  }
}

class SettingsScreen extends StatefulWidget {
  static String tag = "settings-screen";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _logOut() {
    Auth auth = Auth.getInstance();
    auth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.tag, (Route r) => (r == null));
  }


  void _testPeer() {
    CryptoPeer.send();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text("Innstillinger")),
        body: ListView(
            children: <Widget>[
              ListTile(
                  title: Text("Logg ut"),
                  onTap: () {
                    _logOut();
                  }
              ),
              ListTile(title: Text("take me for a test run"), onTap: () {
                _testPeer();
              })
            ]
        )
    );
  }
}


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    sockets.initCommunication();
    return new MaterialApp(
      title: 'WebSockets Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(actions: <Widget>[IconButton(icon: Icon(Icons.info), onPressed: _ok)],),
        body: Text("HOME")
      ),
    );
  }

  _ok() {
    print("sending");
    sockets.send(json.encode({'action':'echo', 'data':'data'}));
  }

}