import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasscodeSetter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Rebuilding passcode setter");
    String passcode1 = "passcode1"; // may be dangerous to store variables here
    String passcode2 = "passcode2"; // may be dangerous to store variables here

    return Scaffold(body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Set your passcode"),
            onChanged: (value) => passcode1 = value
          )
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Verify your passcode"),
            onChanged: (value) => passcode2 = value
          )
        ),
        Padding(
          padding: EdgeInsets.all(40),
          child: Builder(builder: (context1) => RaisedButton(
            color: Theme.of(context1).primaryColor,
            child: Text("Set passcode", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
            onPressed: () {
              if (passcode1 == passcode2)
                setPasscode(passcode1).then((b) => Navigator.popAndPushNamed(context1, "/main"));
              else Scaffold.of(context1).showSnackBar(SnackBar(content: Text("Passcode fields differ!")));
            }
          ))
        )
      ]
    )));
  }

  Future<bool> setPasscode(String passcode) async {
    final storage = await SharedPreferences.getInstance();
    return storage.setString("passcode", passcode);
  }
}
