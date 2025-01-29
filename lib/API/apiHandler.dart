import 'dart:convert';
import 'package:adilco/Models/Users.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "http://10.0.2.2:5093/api/Users/Register";

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
    } catch (e) {
      return http.Response('Error: $e', 500);
    }

    return response;
  }
}
