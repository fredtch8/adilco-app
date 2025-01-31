import 'dart:convert';
import 'package:adilco/API/apiHandler.dart';
import 'package:adilco/Auth/forgotPass2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class forgotPass extends StatefulWidget {
  @override
  _forgotPassState createState() => _forgotPassState();
}

class _forgotPassState extends State<forgotPass> {
  final TextEditingController _emailPhoneController = TextEditingController();
  String? _errorMessage;
  String? deviceToken;

  ApiHandler apihandler = ApiHandler();

  void checkUserExists() async {
    final response =
        await apihandler.checkUserExists(_emailPhoneController.text.trim());

    if (response.statusCode == 200) {
      // Success
      if (!mounted) return;
      var responseBody = jsonDecode(response.body);
      bool userExists = responseBody['exists'];

      if (userExists) {
        // If the user exists, call another API (just commented for now)
        // await anotherApiCall();
        var userId = responseBody['user']['UserId'];
        var input = responseBody['user']['Input'];

        sendOTP(userId, input);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User exists, proceeding with next steps.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // If the user doesn't exist, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email/Phone do not have an account registered.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      // Failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contact Adilco: ${response.body}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

//send otp and save it in database, assume otp is sent to user for now
  void sendOTP(int userId, String input) async {
    final response = await apihandler.generateOTP(userId);

    if (response.statusCode == 200) {
      //var responseBody = jsonDecode(response.body);
      //String AccessToken = responseBody['AccessToken'];
      //int OtpValue = responseBody['OtpValue'];

      //await sendOtpNotification(AccessToken, OtpValue);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => forgotPass2(
                  emailOrPhone: input,
                  userId: userId,
                )),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent, enter it and change your password.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),
      );
    } else {
      // Failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contact Adilco: ${response.body}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Function to send OTP via FCM (V1 API)
  // Future<void> sendOtpNotification(String token, int otp) async {
  //   String otpVal = otp.toString();

  //   try {
  //     final payload = {
  //       "message": {
  //         "token": token,
  //         "notification": {
  //           "title": "Password Reset OTP",
  //           "body": "Your OTP is: $otpVal. Use it to reset your password."
  //         }
  //       }
  //     };

  //     // Replace YOUR_ACCESS_TOKEN with the access token you obtained from your backend
  //     String accessToken = token;

  //     // Make a POST request to the Firebase Cloud Messaging V1 API
  //     final response = await http.post(
  //       Uri.parse(
  //           "https://fcm.googleapis.com/v1/projects/adilco-34a31/messages:send"),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $accessToken', // Use the access token here
  //       },
  //       body: jsonEncode(payload),
  //     );

  //     if (response.statusCode == 200) {
  //       print("OTP notification sent successfully.");
  //     } else {
  //       print("Failed to send OTP notification: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error sending OTP notification: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset Password',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const CircleAvatar(
                  backgroundImage: AssetImage('images/adilco-logo.jpg'),
                  radius: 50,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Reset Your Password',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _emailPhoneController,
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    labelText: 'Email/Phone',
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black38),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: const Icon(
                      Icons.person_3_rounded,
                      color: Colors.red,
                    ),
                    errorText: _errorMessage,
                  ),
                ),
                const SizedBox(height: 20),
                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Check if the email/phone field is empty
                        if (_emailPhoneController.text.isEmpty) {
                          _errorMessage = 'Email/Phone is required';
                        } else {
                          _errorMessage = null;

                          //make API Call to check if username/phone exists in database amd has a user meaning its valid
                          checkUserExists();
                          //if yes send the OTP to user email or phone
                          //if successfully sent go to next page

                          // Navigate to the second page if valid
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => forgotPass2(
                          //             emailOrPhone: _emailPhoneController.text,
                          //           )),
                          // );
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
