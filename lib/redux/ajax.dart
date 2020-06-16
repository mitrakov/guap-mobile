import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:guap_mobile/category/category.dart';
import 'package:guap_mobile/item/item.dart';
import 'package:guap_mobile/login/login.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:http/http.dart' as http;
import 'package:guap_mobile/person/person.dart';

class Ajax {
  static final baseUrl = "http://mitrakoff.com:8888/varlam";
  static String token = "";

  static Future<void> signIn(String name, String purePassword) {
    print("$name, $purePassword");
    final hash = sha256.convert(utf8.encode(purePassword)).toString();
    final request = LoginRequest(name, hash);
    print("Ajax prepare: ${json.encode(request.toJson())}");

    return http.put("$baseUrl/sign/in", body: json.encode(request.toJson())).asStream().map((response) {
      if (response.statusCode == 200) {
        print("Ajax sign in: ${response.body}");
        final tokenResponse = TokenResponse.fromJson(json.decode(response.body));
        if (tokenResponse.code == 0) {
          token = tokenResponse.token;
        } else throw Exception("Failed to sign in (error code ${tokenResponse.code})");
      }
      else throw Exception("Failed to sign in (http code ${response.statusCode})");
    }).single;
  }

  static Future<List<String>> fetchPersons() {
    final headers = {"username": "Tommy", "token": token}; // TODO
    return http.get("$baseUrl/person/list", headers: headers).asStream().map((response) {
      if (response.statusCode == 200) {
        print("Ajax persons: ${response.body}");
        final personResponse = PersonResponse.fromJson(json.decode(response.body));
        if (personResponse.code == 0)
          return personResponse.personsUtf8;
        else throw Exception("Failed to load persons (error code ${personResponse.code})");
      }
      else throw Exception("Failed to load persons (http code ${response.statusCode})");
    }).single;
  }

  static Future<List<Category>> fetchCategoriesTree() {
    final headers = {"username": "Tommy", "token": token};
    return http.get("$baseUrl/category/list", headers: headers).asStream().map((response) {
      if (response.statusCode == 200) {
        print("Ajax categories tree: ${response.body}");
        final categoryResponse = CategoryResponse.fromJson(json.decode(response.body));
        if (categoryResponse.code == 0)
          return categoryResponse.categories;
        else throw Exception("Failed to load categories (error code ${categoryResponse.code})");
      }
      else throw Exception("Failed to load categories (http code ${response.statusCode})");
    }).single;
  }

  static Future<List<String>> fetchItems(String category) {
    final headers = {"username": "Tommy", "token": token};
    return http.get("$baseUrl/item/list?category=$category", headers: headers).asStream().map((response) {
      if (response.statusCode == 200) {
        print("Ajax items: ${response.body}");
        final itemResponse = ItemResponse.fromJson(json.decode(response.body));
        if (itemResponse.code == 0)
          return itemResponse.itemsUtf8;
        else throw Exception("Failed to load items (error code ${itemResponse.code})");
      }
      else throw Exception("Failed to load items (http code ${response.statusCode})");
    }).single;
  }

  static Future<List<int>> fetchOperations(String category) {
    final headers = {"username": "Tommy", "token": token};
    return http.get("$baseUrl/operation/list?category=$category", headers: headers).asStream().map((response) {
      if (response.statusCode == 200) {
        print("Ajax operations: ${response.body}");
        final operationListResponse = OperationListResponse.fromJson(json.decode(response.body));
        if (operationListResponse.code == 0)
          return operationListResponse.ids;
        else throw Exception("Failed to load operations (error code ${operationListResponse.code})");
      }
      else throw Exception("Failed to load operations (http code ${response.statusCode})");
    }).single;
  }

  static Future<Operation> fetchOperation(int id) {
    final headers = {"username": "Tommy", "token": token};
    return http.get("$baseUrl/operation/get?id=$id", headers: headers).asStream().map((response) {
      if (response.statusCode == 200) {
        print("Ajax operation: ${response.body}");
        final operationResponse = OperationResponse.fromJson(json.decode(response.body));
        if (operationResponse.code == 0)
          return operationResponse.operation;
        else throw Exception("Failed to load operation (error code ${operationResponse.code})");
      }
      else throw Exception("Failed to load operation (http code ${response.statusCode})");
    }).single;
  }

  static Future<void> addOperation(AddOperationRequest operation) {
    print("Ajax prepare: ${json.encode(operation.toJson())}");
    final headers = {"username": "Tommy", "token": token};
    return http.post("$baseUrl/operation/new", headers: headers, body: json.encode(operation.toJson())).asStream().map((response) {
      if (response.statusCode == 200) {
        print("Ajax add operation: ${response.body}");
        final operationResponse = AddOperationResponse.fromJson(json.decode(response.body));
        if (operationResponse.code == 0) return;
        else throw Exception("Failed to add operation (error code ${operationResponse.code})");
      }
      else throw Exception("Failed to add operation (http code ${response.statusCode})");
    }).single;
  }
}
