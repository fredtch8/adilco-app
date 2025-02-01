import 'dart:convert';

import 'package:adilco/API/apiHandler.dart';
import 'package:adilco/Auth/login.dart';
import 'package:adilco/loading.dart';
import 'package:flutter/material.dart';

class forgotPass2 extends StatefulWidget {
  final String emailOrPhone;
  final int userId;

  const forgotPass2({
    super.key,
    required this.emailOrPhone,
    required this.userId,
  });

  @override
  _forgotPass2State createState() => _forgotPass2State();
}

class _forgotPass2State extends State<forgotPass2> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool isLoading = false;

  String? OTPerrorMsg;
  String? NewPassErrorMsg;
  String? ConfirmNewPassErrorMsg;

  ApiHandler apihandler = ApiHandler();

  void checkOTPValidity() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      // Make the API call
      final response = await apihandler.checkOTPResetPass(
        widget.userId,
        int.parse(_otpController.text.trim()),
        _newPasswordController.text.trim(),
        _confirmPasswordController.text.trim(),
      );

      // Decode the response and get the message
      var data = jsonDecode(response.body);
      String message = data["message"];

      if (response.statusCode == 200) {
        // Navigate to the Login screen on success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );

        // Show success message in a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
      } else if (response.statusCode == 400) {
        // Show error message for bad request
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      } else {
        // Handle other status codes
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Retry updating password'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      // Handle any unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    } finally {
      // Hide the loading indicator
      setState(() {
        isLoading = false;
      });
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
          // Main content
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
                    const SizedBox(height: 10),
                    const Text(
                      'Enter OTP, new password, and confirm password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // OTP Field
                    TextField(
                      controller: _otpController,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        labelText: 'OTP',
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
                          Icons.lock_clock,
                          color: Colors.red,
                        ),
                        errorText: OTPerrorMsg,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // New Password Field
                    TextField(
                      controller: _newPasswordController,
                      obscureText: !_isPasswordVisible,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        labelText: 'New Password',
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
                          Icons.lock,
                          color: Colors.red,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        errorText: NewPassErrorMsg,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Confirm Password Field
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
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
                          Icons.lock_outline,
                          color: Colors.red,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        errorText: ConfirmNewPassErrorMsg,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Reset Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                setState(() {
                                  OTPerrorMsg = null;
                                  NewPassErrorMsg = null;
                                  ConfirmNewPassErrorMsg = null;

                                  if (_otpController.text.isEmpty) {
                                    OTPerrorMsg = 'OTP is a required field';
                                  }
                                  if (_newPasswordController.text.isEmpty) {
                                    NewPassErrorMsg =
                                        'New Password is a required field';
                                  }
                                  if (_confirmPasswordController.text.isEmpty) {
                                    ConfirmNewPassErrorMsg =
                                        'Confirm New Password is a required field';
                                  }

                                  if (OTPerrorMsg == null &&
                                      NewPassErrorMsg == null &&
                                      ConfirmNewPassErrorMsg == null) {
                                    // Perform validation and API call
                                    if ((_newPasswordController.text !=
                                        _confirmPasswordController.text)) {
                                      ConfirmNewPassErrorMsg =
                                          'Passwords do not match';
                                    } else {
                                      // Check in database if OTP is correct and update data
                                      // Call API to reset password with the data passed
                                      // Handle response accordingly
                                      checkOTPValidity();
                                    }
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
                          'Reset Password',
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

          // Loading Animation Overlay
          if (isLoading) // Conditionally show the loading animation
            const Center(
              child: LoadingWidget(), // Show loading indicator
            ),
        ],
      ),
    );
  }
}
