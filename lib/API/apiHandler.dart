import 'dart:convert';
import 'package:adilco/Models/Users.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  //FOR ANDROID EMULATORS
  final String baseUri = "http://10.0.2.2:5093/api/Users/Register";
  final String checkUri = "http://10.0.2.2:5093/api/Users/ForgetPassCheckUser";
  final String generateOtpUri = "http://10.0.2.2:5093/api/Otp/GenerateOTP";
  final String checkOtpUri = "http://10.0.2.2:5093/api/Otp/VerifyOTPResetPass";
  final String loginUri = "http://10.0.2.2:5093/api/Users/Login";
  final String logoutUri = "http://10.0.2.2:5093/api/Users/logout";
  final String getUserInfoUri = "http://10.0.2.2:5093/api/Users/profile/";
  final String changePasswordUri =
      "http://10.0.2.2:5093/api/Users/update-password";

  //FOR REAL DEVICE PHONE
  // final String baseUri = "http://192.168.10.142:5093/api/Users/Register";
  // final String checkUri =
  //     "http://192.168.10.142:5093/api/Users/ForgetPassCheckUser";
  // final String generateOtpUri =
  //     "http://192.168.10.142:5093/api/Otp/GenerateOTP";
  // final String checkOtpUri =
  //     "http://192.168.10.142:5093/api/Otp/VerifyOTPResetPass";
  // final String loginUri = "http://192.168.10.142:5093/api/Users/Login";
  //final String logoutUri = "http://192.168.10.142:5093/api/Users/logout";

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

  Future<http.Response> login(String username, String password) async {
    final uri = Uri.parse(loginUri);
    http.Response? response;

    try {
      final requestBody =
          json.encode({'USERNAME': username, 'PASSWORD': password});

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

  Future<http.Response> logout(String? token) async {
    final uri = Uri.parse(logoutUri);
    http.Response? response;

    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'X-Token':
              token.toString(), // Send token in the custom X-Token header
        },
      );
    } catch (e) {
      return http.Response('Error: $e', 500);
    }

    return response;
  }

  Future<http.Response> getUserInfo(int userId, String? token) async {
    final uri = Uri.parse(getUserInfoUri + userId.toString());

    // Check if token is null or empty before making the request
    if (token == null || token.isEmpty) {
      return http.Response('Error: Token is missing', 400);
    }

    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Attach token as Bearer
        },
      );

      return response;
    } catch (e) {
      print("GetUserInfo API Error: $e"); // Log error
      return http.Response('Error: Failed to connect to server', 500);
    }
  }

  Future<http.Response> changePassword(int userId, String? token,
      String oldPassword, String newPassword, String confirmPassword) async {
    final uri = Uri.parse(changePasswordUri);

    // Check if token is null or empty before making the request
    if (token == null || token.isEmpty) {
      return http.Response('Error: Token is missing', 400);
    }

    final requestBody = json.encode({
      'userId': userId,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword
    });

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Attach token as Bearer
        },
        body: requestBody,
      );

      return response;
    } catch (e) {
      return http.Response('Error: Failed to connect to server', 500);
    }
  }
}
