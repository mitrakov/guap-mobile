import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasscodeChecker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PasscodeCheckerState();
}

class PasscodeCheckerState extends State<PasscodeChecker> {
  final TextEditingController curPasscodeCtrl = TextEditingController();
  final TextEditingController myPasscodeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Rebuilding passcode checker");
    return Scaffold(body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          obscureText: true,
          controller: myPasscodeCtrl,
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Input a passcode"),
        ),
        Padding(
          padding: EdgeInsets.all(40),
          child: Builder(builder: (context1) => ElevatedButton(
              child: Text("Verify", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
              onPressed: () {
                if (myPasscodeCtrl.text == curPasscodeCtrl.text)
                  Navigator.popAndPushNamed(context1, "/main");
                else ScaffoldMessenger.of(context1).showSnackBar(SnackBar(content: Text("Incorrect passcode")));
              },
          ))
        ),
      ],
    )));
  }

  @override
  void initState() {
    // checking if the local storage has a passcode. If not, the app is open for the first time => move to login screen
    super.initState();
    SharedPreferences.getInstance().then((storage) {
      if (storage.containsKey("passcode"))
        curPasscodeCtrl.text = storage.getString("passcode") ?? "";
      else Future.delayed(Duration(seconds: 0), () => Navigator.popAndPushNamed(context, "/login"));
    });
  }
}
