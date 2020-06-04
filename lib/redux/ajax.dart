import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:guap_mobile/person/person.dart';

class Ajax {
  static final baseUrl = "http://mitrakoff.com:8888/varlam";

  Future<List<String>> fetchPersons() {
    var headers = {"username": "Tommy", "token": "33dbd779129f406bbbb003aecd23e96f"};
    return http.get("$baseUrl/person/list", headers: headers).asStream().map((response) {
      if (response.statusCode == 200) {
        final personResponse = PersonResponse.fromJson(json.decode(response.body));
        if (personResponse.code == 0)
          return personResponse.getPersons();
        else throw Exception("Failed to load persons (error code ${personResponse.code})");
      }
      else throw Exception("Failed to load persons (http code ${response.statusCode})");
    }).single;
  }
}
