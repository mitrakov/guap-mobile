import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String url;

  const FullScreenImage(this.url, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87),
      body: Container(
        color: Colors.black87,
        child: RotatedBox(
          quarterTurns: 1,
          child: Image.network(
            url,
            fit: BoxFit.scaleDown,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
