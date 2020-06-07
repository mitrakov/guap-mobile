import 'dart:convert';
import 'package:guap_mobile/category/category.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:http/http.dart' as http;
import 'package:guap_mobile/person/person.dart';

class Ajax {
  static final baseUrl = "http://mitrakoff.com:8888/varlam";
  static final token = "1617b58596f14cddb31cf153d977954d";

  Future<List<String>> fetchPersons() {
    var headers = {"username": "Tommy", "token": token};
    return http.get("$baseUrl/person/list", headers: headers).asStream().map((response) {
      if (response.statusCode == 200) {
        print("Ajax made: ${response.body}");
        final personResponse = PersonResponse.fromJson(json.decode(response.body));
        if (personResponse.code == 0)
          return personResponse.getPersons();
        else throw Exception("Failed to load persons (error code ${personResponse.code})");
      }
      else throw Exception("Failed to load persons (http code ${response.statusCode})");
    }).single;
  }

  Future<List<Category>> fetchCategoriesTree() {
    var headers = {"username": "Tommy", "token": token};
    return http.get("$baseUrl/category/list", headers: headers).asStream().map((response) {
      if (response.statusCode == 200) {
        print("Ajax made: ${response.body}");
        final categoryResponse = CategoryResponse.fromJson(json.decode(response.body));
        if (categoryResponse.code == 0)
          return categoryResponse.categories;
        else throw Exception("Failed to load categories (error code ${categoryResponse.code})");
      }
      else throw Exception("Failed to load categories (http code ${response.statusCode})");
    }).single;
  }

  Future<List<int>> fetchOperations() {
    var headers = {"username": "Tommy", "token": token};
    return http.get("$baseUrl/operations/list", headers: headers).asStream().map((response) {
      if (response.statusCode == 200) {
        print("Ajax made: ${response.body}");
        final operationListResponse = OperationListResponse.fromJson(json.decode(response.body));
        if (operationListResponse.code == 0)
          return operationListResponse.ids;
        else throw Exception("Failed to load operations (error code ${operationListResponse.code})");
      }
      else throw Exception("Failed to load operations (http code ${response.statusCode})");
    }).single;
  }
}
