import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'backend.dart';
import 'auth.dart';
import 'user.dart';

void main() => runApp(Monica());


class Monica extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    LoginPage.tag: (context) => LoginPage()
  };

  Widget build(BuildContext context) {

    Backend.init();

    //for testing
    //getUserData();

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
      appBar: AppBar(title: Text("Loading")),
      body: Center(child:CircularProgressIndicator())
    );
    return g;
  }
}

// not used since 19.1
class MonicaScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Monica")),
        body: Center(
            child: ListView(
                children: [
                  Text("Monica start"),
                  MaterialButton(
                      child: Text("Button"),
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginPage.tag);
                      }

                  )
                ]
            )
        )
    );
  }
}