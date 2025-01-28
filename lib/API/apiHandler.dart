import 'dart:convert';
import 'package:adilco/Models/Users.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "http://192.168.10.142:7050/api/Users/Register";

  Future<http.Response> registerUser(Users user) async {
    final uri = Uri.parse(baseUri);
    http.Response? response;

    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200) {
        print("User registered successfully!");
      } else {
        print("Failed to register user. Status code: ${response.statusCode}");
      }
    } catch (e) {
      return http.Response('Error: $e', 500);
    }

    return response ??
        http.Response('Failed to register', 500); // Default failure message
  }
}
