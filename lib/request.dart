import 'package:flutter/material.dart';
import 'package:guap_mobile/person.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Operations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Request();
}

class Request extends State<Operations>{
  Future<PersonResponse> categoriesFut;

  Future<PersonResponse> fetchOperation() {
    var url = "http://mitrakoff.com:8888/varlam/person/list";
    var headers = {"username": "Tommy", "token": "02ae01a69d774ae389c827a9f9395f62"};
    return http.get(url, headers: headers).asStream().map((response) {
      if (response.statusCode == 200)
        return PersonResponse.fromJson(json.decode(response.body));
      else throw Exception("Failed to load categories");
    }).single;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categoriesFut,
      builder: (ctxt, snapshot) {
        if (snapshot.hasData)
          return Text(snapshot.data.persons[0]);
        else if (snapshot.hasError)
          return Text("${snapshot.error}");

        return CircularProgressIndicator();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    categoriesFut = fetchOperation();
  }
}
