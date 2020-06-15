import 'package:flutter/material.dart';
import 'package:guap_mobile/login/login.dart';
import 'package:guap_mobile/redux/ajax.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // no need in Stateful widget for these 4 variables:
    String login;
    String password;

    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Login"),
              onChanged: (value) => login = value // TODO onSubmitted?
            )
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
              onChanged: (value) => password = value // TODO onSubmitted?
            )
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text("Sign in", style: TextStyle(color: Theme.of(context).primaryColorLight, fontWeight: FontWeight.w800, fontSize: 18)),
              onPressed: () => Ajax.signIn(LoginRequest(login, password)),
            ),
          )
        ]
      )
    ));
  }
}
