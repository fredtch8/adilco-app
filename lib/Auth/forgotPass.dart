import 'dart:convert';
import 'package:adilco/API/apiHandler.dart';
import 'package:adilco/Auth/forgotPass2.dart';
import 'package:adilco/loading.dart';
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
  bool isLoading = false; // Track loading state

  ApiHandler apihandler = ApiHandler();

  void checkUserExists() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      final response =
          await apihandler.checkUserExists(_emailPhoneController.text.trim());

      if (response.statusCode == 200) {
        // Success
        if (!mounted) return;
        var responseBody = jsonDecode(response.body);
        bool userExists = responseBody['exists'];

        if (userExists) {
          var userId = responseBody['user']['UserId'];
          var input = responseBody['user']['Input'];

          await sendOTP(userId, input); // Wait for OTP to be sent
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
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  // Send OTP and save it in the database
  Future<void> sendOTP(int userId, String input) async {
    try {
      final response = await apihandler.generateOTP(userId);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => forgotPass2(
              emailOrPhone: input,
              userId: userId,
            ),
          ),
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
            content: Text(response.body),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending OTP: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
      body: Stack(
        children: [
          Container(
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
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2),
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
                        onPressed: isLoading
                            ? null // Disable button when loading
                            : () {
                                setState(() {
                                  // Check if the email/phone field is empty
                                  if (_emailPhoneController.text.isEmpty) {
                                    _errorMessage = 'Email/Phone is required';
                                  } else {
                                    _errorMessage = null;
                                    checkUserExists(); // Make API call
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
          // Loading Indicator
          if (isLoading)
            const Center(
              child: LoadingWidget(), // Show loading indicator
            ),
        ],
      ),
    );
  }
}
