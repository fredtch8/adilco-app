import 'dart:convert';

import 'package:adilco/secureStorage.dart';
import 'package:flutter/material.dart';
import 'navigation.dart'; // Import your navigation file
import '../API/apiHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ProfileState();
}

class _ProfileState extends State<ChangePassword> {
  final TextEditingController _oldpassword = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();
  final TextEditingController _confirmnewpass = TextEditingController();

  String? _oldpasswordError;
  String? _newpasswordError;
  String? _confirmnewpassError;

  ApiHandler apihandler = ApiHandler();

  void changePassword() async {
    final userId = await SecureStorage.read('userId');
    final token = await SecureStorage.read('auth_token');

    final response = await apihandler.changePassword(
        int.parse(userId!),
        token,
        _oldpassword.text.trim(),
        _newpassword.text.trim(),
        _confirmnewpass.text.trim());

    if (response.statusCode == 200) {
      // ✅ Success: Show success message
      showSuccess("Password changed successfully!");
    } else {
      // ❌ Failure: Show error message from API response
      var data = jsonDecode(response.body);
      String errorMessage = data['message'] ??
          "Failed to change password."; // Handle 'message' key
      showError(errorMessage);
    }
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Password Change',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: const Navigation(), // Add the navigation drawer
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFCE4EC),
              Color(0xFFF8BBD0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const CircleAvatar(
                  backgroundImage: AssetImage('images/adilco-logo.jpg'),
                  radius: 50,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Change Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Update your password below',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  label: 'Old Password',
                  myController: _oldpassword,
                  errorText: _oldpasswordError,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'New Password',
                  myController: _newpassword,
                  errorText: _newpasswordError,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Confirm Password',
                  myController: _confirmnewpass,
                  errorText: _confirmnewpassError,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _oldpasswordError = null;
                        _newpasswordError = null;
                        _confirmnewpassError = null;

                        if (_oldpassword.text.trim().isEmpty) {
                          _oldpasswordError = 'Old Password is required';
                        }
                        if (_newpassword.text.trim().isEmpty) {
                          _newpasswordError = 'New Password is required';
                        }
                        if (_confirmnewpass.text.trim().isEmpty) {
                          _confirmnewpassError =
                              'Confirm new Password is required';
                        }

                        if (_newpassword.text.trim() !=
                            _confirmnewpass.text.trim()) {
                          _confirmnewpassError = 'Passwords do not match';
                        } else {
                          //change pass call api
                          changePassword();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: const Color.fromARGB(255, 48, 45, 45),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController myController,
    required String? errorText,
  }) {
    return TextField(
      controller: myController,
      cursorColor: Colors.red,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black54,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        errorText: errorText,
      ),
      style: const TextStyle(color: Colors.black87),
    );
  }
}
