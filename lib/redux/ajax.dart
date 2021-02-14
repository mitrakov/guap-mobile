import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guap_mobile/category/category.dart';
import 'package:guap_mobile/chart/chart.dart';
import 'package:guap_mobile/item/item.dart';
import 'package:guap_mobile/login/login.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/redux/common.dart';
import 'package:guap_mobile/person/person.dart';

class Ajax {
  static final baseUrl = "https://guap.mitrakoff.com/varlam";
  static String _username = "";
  static String _token = "";

  static Future<void> signIn(String name, String purePassword) async {
    final hash = sha256.convert(utf8.encode(purePassword)).toString();
    final request = LoginRequest(name, hash);
    print("Ajax prepare: ${json.encode(request.toJson())}");

    final response = await http.put("$baseUrl/sign/in", body: json.encode(request.toJson()));
    if (response.statusCode == 200) {
      print("Ajax sign in: ${response.body}");
      final tokenResponse = TokenResponse.fromJson(json.decode(response.body));
      if (tokenResponse.code == 0) {
        _saveHeaders(tokenResponse.token, name);
      } else throw Exception("Failed to sign in (error code ${tokenResponse.code})");
    } else throw Exception("Failed to sign in (http code ${response.statusCode})");
  }

  static Future<List<String>> fetchPersons() async {
    final response = await http.get("$baseUrl/person/list", headers: await _headers());
    if (response.statusCode == 200) {
      print("Ajax persons: ${response.body}");
      final personResponse = PersonResponse.fromJson(json.decode(response.body));
      if (personResponse.code == 0)
        return personResponse.personsUtf8;
      else throw Exception("Failed to load persons (error code ${personResponse.code})");
    } else throw Exception("Failed to load persons (http code ${response.statusCode})");
  }

  static Future<void> addPerson(AddPersonRequest person) async {
    print("Ajax prepare: ${json.encode(person.toJson())}");
    final response = await http.post("$baseUrl/person/new", headers: await _headers(), body: json.encode(person.toJson()));
    if (response.statusCode == 200) {
      print("Ajax add person: ${response.body}");
      final personResponse = CommonResponse.fromJson(json.decode(response.body));
      if (personResponse.code == 0) return;
      else throw Exception("Failed to add person (error code ${personResponse.code})");
    } else throw Exception("Failed to add person (http code ${response.statusCode})");
  }

  static Future<void> changePerson(ChangePersonRequest personRequest) async {
    print("Ajax prepare: ${json.encode(personRequest.toJson())}");
    final response = await http.put("$baseUrl/person/change", headers: await _headers(), body: json.encode(personRequest.toJson()));
    if (response.statusCode == 200) {
      print("Ajax change person: ${response.body}");
      final personResponse = CommonResponse.fromJson(json.decode(response.body));
      if (personResponse.code == 0) return;
      else throw Exception("Failed to change person (error code ${personResponse.code})");
    } else throw Exception("Failed to change person (http code ${response.statusCode})");
  }

  static Future<void> removePerson(RemovePersonRequest personRequest) async {
    final request = http.Request("DELETE", Uri.parse("$baseUrl/person/delete"));
    request.headers.addAll(await _headers());
    request.body = json.encode(personRequest.toJson());
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print("Ajax delete person: $responseBody");
      final personResponse = CommonResponse.fromJson(json.decode(responseBody));
      if (personResponse.code == 0) return;
      else throw Exception("Failed to delete person (error code ${personResponse.code})");
    } else throw Exception("Failed to delete person (http code ${response.statusCode})");
  }

  static Future<List<Category>> fetchCategoriesTree() async {
    final response = await http.get("$baseUrl/category/list", headers: await _headers());
    if (response.statusCode == 200) {
      print("Ajax categories tree: ${response.body}");
      final categoryResponse = CategoryResponse.fromJson(json.decode(response.body));
      if (categoryResponse.code == 0)
        return categoryResponse.categories;
      else throw Exception("Failed to load categories (error code ${categoryResponse.code})");
    } else throw Exception("Failed to load categories (http code ${response.statusCode})");
  }

  static Future<void> changeCategory(ChangeCategoryRequest categoryRequest) async {
    print("Ajax prepare: ${json.encode(categoryRequest.toJson())}");
    final response = await http.put("$baseUrl/category/change", headers: await _headers(), body: json.encode(categoryRequest.toJson()));
    if (response.statusCode == 200) {
      print("Ajax change category: ${response.body}");
      final categoryResponse = CommonResponse.fromJson(json.decode(response.body));
      if (categoryResponse.code == 0) return;
      else throw Exception("Failed to change category (error code ${categoryResponse.code})");
    } else throw Exception("Failed to change category (http code ${response.statusCode})");
  }

  static Future<void> removeCategory(RemoveCategoryRequest categoryRequest) async {
    final request = http.Request("DELETE", Uri.parse("$baseUrl/category/delete"));
    request.headers.addAll(await _headers());
    request.body = json.encode(categoryRequest.toJson());
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print("Ajax delete category: $responseBody");
      final categoryResponse = CommonResponse.fromJson(json.decode(responseBody));
      if (categoryResponse.code == 0) return;
      else throw Exception("Failed to delete category (error code ${categoryResponse.code})");
    } else throw Exception("Failed to delete category (http code ${response.statusCode})");
  }

  static Future<List<String>> fetchItems(String category) async {
    final response = await http.get("$baseUrl/item/list?category=$category", headers: await _headers());
    if (response.statusCode == 200) {
      print("Ajax items: ${response.body}");
      final itemResponse = ItemResponse.fromJson(json.decode(response.body));
      if (itemResponse.code == 0)
        return itemResponse.itemsUtf8;
      else throw Exception("Failed to load items (error code ${itemResponse.code})");
    } else throw Exception("Failed to load items (http code ${response.statusCode})");
  }

  static Future<void> changeItem(ChangeItemRequest itemRequest) async {
    print("Ajax prepare: ${json.encode(itemRequest.toJson())}");
    final response = await http.put("$baseUrl/item/change", headers: await _headers(), body: json.encode(itemRequest.toJson()));
    if (response.statusCode == 200) {
      print("Ajax change item: ${response.body}");
      final itemResponse = CommonResponse.fromJson(json.decode(response.body));
      if (itemResponse.code == 0) return;
      else throw Exception("Failed to change item (error code ${itemResponse.code})");
    } else throw Exception("Failed to change item (http code ${response.statusCode})");
  }

  static Future<void> removeItem(RemoveItemRequest itemRequest) async {
    final request = http.Request("DELETE", Uri.parse("$baseUrl/item/delete"));
    request.headers.addAll(await _headers());
    request.body = json.encode(itemRequest.toJson());
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print("Ajax delete item: $responseBody");
      final itemResponse = CommonResponse.fromJson(json.decode(responseBody));
      if (itemResponse.code == 0) return;
      else throw Exception("Failed to delete item (error code ${itemResponse.code})");
    } else throw Exception("Failed to delete item (http code ${response.statusCode})");
  }

  static Future<List<int>> fetchOperations(String category) async {
    final response = await http.get("$baseUrl/operation/list?category=$category", headers: await _headers());
    if (response.statusCode == 200) {
      print("Ajax operations: ${response.body}");
      final operationListResponse = OperationListResponse.fromJson(json.decode(response.body));
      if (operationListResponse.code == 0)
        return operationListResponse.ids;
      else throw Exception("Failed to load operations (error code ${operationListResponse.code})");
    } else throw Exception("Failed to load operations (http code ${response.statusCode})");
  }

  static Future<Operation> fetchOperation(int id) async {
    final response = await http.get("$baseUrl/operation/get?id=$id", headers: await _headers());
    if (response.statusCode == 200) {
      print("Ajax operation: ${response.body}");
      final operationResponse = OperationResponse.fromJson(json.decode(response.body));
      if (operationResponse.code == 0)
        return operationResponse.operation;
      else throw Exception("Failed to load operation (error code ${operationResponse.code})");
    } else throw Exception("Failed to load operation (http code ${response.statusCode})");
  }

  static Future<void> addOperation(AddOperationRequest operation) async {
    print("Ajax prepare: ${json.encode(operation.toJson())}");
    final response = await http.post("$baseUrl/operation/new", headers: await _headers(), body: json.encode(operation.toJson()));
    if (response.statusCode == 200) {
      print("Ajax add operation: ${response.body}");
      final operationResponse = CommonResponse.fromJson(json.decode(response.body));
      if (operationResponse.code == 0) return;
      else throw Exception("Failed to add operation (error code ${operationResponse.code})");
    } else throw Exception("Failed to add operation (http code ${response.statusCode})");
  }

  static Future<void> changeOperation(ChangeOperationRequest operation) async {
    print("Ajax prepare: ${json.encode(operation.toJson())}");
    final response = await http.put("$baseUrl/operation/change", headers: await _headers(), body: json.encode(operation.toJson()));
    if (response.statusCode == 200) {
      print("Ajax change operation: ${response.body}");
      final operationResponse = CommonResponse.fromJson(json.decode(response.body));
      if (operationResponse.code == 0) return;
      else throw Exception("Failed to change operation (error code ${operationResponse.code})");
    } else throw Exception("Failed to change operation (http code ${response.statusCode})");
  }

  static Future<void> removeOperation(RemoveOperationRequest operation) async {
    final request = http.Request("DELETE", Uri.parse("$baseUrl/operation/delete"));
    request.headers.addAll(await _headers());
    request.body = json.encode(operation.toJson());
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print("Ajax delete operation: $responseBody");
      final operationResponse = CommonResponse.fromJson(json.decode(responseBody));
      if (operationResponse.code == 0) return;
      else throw Exception("Failed to delete operation (error code ${operationResponse.code})");
    } else throw Exception("Failed to delete operation (http code ${response.statusCode})");
  }

  static Future<void> addItem(AddItemRequest item) async {
    print("Ajax prepare: ${json.encode(item.toJson())}");
    final response = await http.post("$baseUrl/item/new", headers: await _headers(), body: json.encode(item.toJson()));
    if (response.statusCode == 200) {
      print("Ajax add item: ${response.body}");
      final itemResponse = CommonResponse.fromJson(json.decode(response.body));
      if (itemResponse.code == 0) return;
      else throw Exception("Failed to add item (error code ${itemResponse.code})");
    } else throw Exception("Failed to add item (http code ${response.statusCode})");
  }

  static Future<String> pieChart(PieChartRequest request) async {
    print("Ajax prepare: ${json.encode(request.toJson())}");
    final response = await http.put("$baseUrl/chart/pie", headers: await _headers(), body: json.encode(request.toJson()));
    if (response.statusCode == 200) {
      print("Ajax pie chart: ${response.body}");
      final uriResponse = UriResponse.fromJson(json.decode(response.body));
      if (uriResponse.code == 0) return uriResponse.url;
      else throw Exception("Failed to request pie chart (error code ${uriResponse.code})");
    } else throw Exception("Failed to request pie chart (http code ${response.statusCode})");
  }

  static Future<String> timeChart(TimeChartRequest request) async {
    print("Ajax prepare: ${json.encode(request.toJson())}");
    final response = await http.put("$baseUrl/chart/time", headers: await _headers(), body: json.encode(request.toJson()));
    if (response.statusCode == 200) {
      print("Ajax time chart: ${response.body}");
      final uriResponse = UriResponse.fromJson(json.decode(response.body));
      if (uriResponse.code == 0) return uriResponse.url;
      else throw Exception("Failed to request time chart (error code ${uriResponse.code})");
    } else throw Exception("Failed to request time chart (http code ${response.statusCode})");
  }

  static Future<Map<String, String>> _headers() async {
    if (_token.isEmpty || _username.isEmpty) {
      final storage = await SharedPreferences.getInstance();
      _token = storage.containsKey("token") ? storage.getString("token") : "no token";
      _username = storage.containsKey("username") ? storage.getString("username") : "no username";
    }

    return {"username": _username, "token": _token};
  }

  static void _saveHeaders(String token, String name) {
    SharedPreferences.getInstance().then((storage) {
      _token = token;
      _username = name;
      storage.setString("token", token);
      storage.setString("username", name);
    });
  }
}
