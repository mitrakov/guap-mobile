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
    var headers = {"username": "Tommy", "token": "2f909edb87ba43f686046ed58c90e5d4"};
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
        if (snapshot.hasData) {
          PersonResponse p = snapshot.data;
          return Text(p.getPersons()[0]);
        }
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
