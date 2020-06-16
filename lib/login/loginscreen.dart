import 'package:flutter/material.dart';
import 'package:guap_mobile/redux/ajax.dart';

class LoginScreen extends StatefulWidget {
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String login = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    print("Rebuilding Login screen");
    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Login"),
              onChanged: (value) => login = value
            )
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
              onChanged: (value) => password = value
            )
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text("Sign in", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800, fontSize: 18)),
              onPressed: () =>
                  Ajax.signIn(login, password).then((v) => Navigator.popAndPushNamed(context, "/main"))
            )
          )
        ]
      )
    ));
  }
}
