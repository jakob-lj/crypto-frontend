import 'package:flutter/material.dart';
import 'home_page.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  static String tag = "login-page";

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {

    if (Auth.getInstance().getCurrentUser() == null) {
      print("logged out");
    } else print("logged in");

    if (Auth.getInstance().getCurrentUser() != null) {
      print("redirecting");
    }

    return Scaffold(
        appBar: AppBar(title: Text("Logg inn")),
        body: Center(
            child: ListView(children: [
          TextField(
              decoration: InputDecoration(hintText: "E-post"),
              controller: emailController),
          TextField(
            obscureText: true,
            decoration: InputDecoration(hintText: "Passord"),
            controller: passwordController,
          ),
          Text("Logg inn"),
          MaterialButton(
            child: Text("logg inn"),
            onPressed: () {
              print(emailController.text);
              print(passwordController.text);
              handleLoginInput(emailController.text, passwordController.text);
            },
          )
        ])));
  }

  void handleLoginInput(String username, String password) {
    Auth auth = Auth.getInstance();
    print("init");
    auth.signInByEmail(username, password).then( (user) {
      print("returned");
      if (user != null) {
        print("login ok");
        Navigator.of(context).pushReplacementNamed(HomePage.tag);
      } else print("login failed");
    });
  }
}
