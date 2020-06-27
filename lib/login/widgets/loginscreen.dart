import 'package:flutter/material.dart';
import 'package:guap_mobile/redux/ajax.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController loginCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Rebuilding login screen");
    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: loginCtrl,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Login"),
            )
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
            )
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("Sign in", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
              onPressed: () =>
                  Ajax.signIn(loginCtrl.text, passwordCtrl.text).then((v) => Navigator.popAndPushNamed(context, "/setPasscode"))
            )
          )
        ]
      )
    ));
  }
}
