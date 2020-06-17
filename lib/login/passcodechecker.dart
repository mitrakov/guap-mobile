import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasscodeChecker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PasscodeCheckerState();
}

class PasscodeCheckerState extends State<PasscodeChecker> {
  String _curPasscode = "Current password from the local storage";
  String _myPasscode = "My password";

  @override
  Widget build(BuildContext context) {
    print("Rebuilding passcode checker");
    return Scaffold(body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          obscureText: true,
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Input a passcode"),
          onChanged: (value) => _myPasscode = value
        ),
        Padding(
          padding: EdgeInsets.all(40),
          child: Builder(builder: (context1) => RaisedButton(
              color: Theme.of(context1).primaryColor,
              child: Text("Verify", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
              onPressed: () {
                if (_myPasscode == _curPasscode)
                  Navigator.popAndPushNamed(context1, "/main");
                else Scaffold.of(context1).showSnackBar(SnackBar(content: Text("Incorrect passcode")));
              }
          ))
        )
      ],
    )));
  }

  @override
  void initState() {
    // checking if the local storage has a passcode. If not, the app is open for the first time => move to login screen
    super.initState();
    SharedPreferences.getInstance().then((storage) {
      if (storage.containsKey("passcode"))
        _curPasscode = storage.getString("passcode");
      else Future.delayed(Duration(seconds: 0), () => Navigator.popAndPushNamed(context, "/login"));
    });
  }
}
