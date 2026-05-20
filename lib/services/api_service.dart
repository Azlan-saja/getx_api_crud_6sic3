import 'dart:convert';

import 'package:getx_api_crud_6sic3/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Ngapain??
  final baseUrl = "https://jsonplaceholder.typicode.com/users";

  // API Method GET
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Accept": "aplication/json"},
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    }
    return [];
  }

  // API Method POST
  Future<UserModel?> createUser(String name, String email) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"name": name, "email": email}),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  // API Method PUT
  Future<bool> updateUser(int id, String name, String email) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"name": name, "email": email}),
    );

    return response.statusCode == 200;
  }

  // API Method DELETE
  Future<bool> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/$id"),
      headers: {"Accept": "application/json"},
    );

    return response.statusCode == 200 || response.statusCode == 204;
  }
}
