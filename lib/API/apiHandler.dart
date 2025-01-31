import 'dart:convert';
import 'package:adilco/Models/Users.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "http://10.0.2.2:5093/api/Users/Register";
  final String checkUri = "http://10.0.2.2:5093/api/Users/ForgetPassCheckUser";
  final String generateOtpUri = "http://10.0.2.2:5093/api/Otp/GenerateOTP";
  final String checkOtpUri = "http://10.0.2.2:5093/api/Otp/VerifyOTPResetPass";

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

  Future<http.Response> checkUserExists(String? input) async {
    final uri = Uri.parse(checkUri);
    http.Response? response;

    try {
      final requestBody = json.encode({
        'Input': input, // Send input as a key-value pair
      });

      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );
    } catch (e) {
      return http.Response('Error: $e', 500);
    }

    return response;
  }

  Future<http.Response> generateOTP(int userId) async {
    final uri = Uri.parse(generateOtpUri);
    http.Response? response;

    try {
      final requestBody = json.encode({
        'UserId': userId,
      });

      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: requestBody,
      );
    } catch (e) {
      return http.Response('Error: $e', 500);
    }

    return response;
  }

  Future<http.Response> checkOTPResetPass(
      int userId, int otp, String password, String confirmPassword) async {
    final uri = Uri.parse(checkOtpUri);
    http.Response? response;

    try {
      final requestBody = json.encode({
        'UserId': userId,
        'OtpValue': otp,
        'NewPassword': password,
        'ConfirmNewPassword': confirmPassword
      });

      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: requestBody,
      );
    } catch (e) {
      return http.Response('Error: $e', 500);
    }

    return response;
  }
}
