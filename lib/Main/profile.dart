import 'package:flutter/material.dart';
import 'navigation.dart'; // Import your navigation file

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _phoneError;
  String? _usernameError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
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
                  'Profile Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Update your profile information below',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  label: 'First Name',
                  myController: _firstNameController,
                  errorText: _firstNameError,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Last Name',
                  myController: _lastNameController,
                  errorText: _lastNameError,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Email',
                  myController: _emailController,
                  errorText: _emailError,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Phone',
                  myController: _phoneController,
                  errorText: _phoneError,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Username',
                  myController: _usernameController,
                  errorText: _usernameError,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _firstNameError = null;
                        _lastNameError = null;
                        _emailError = null;
                        _phoneError = null;
                        _usernameError = null;

                        if (_firstNameController.text.trim().isEmpty) {
                          _firstNameError = 'First name is required';
                        }
                        if (_lastNameController.text.trim().isEmpty) {
                          _lastNameError = 'Last name is required';
                        }
                        if (_emailController.text.trim().isEmpty) {
                          _emailError = 'Email is required';
                        }
                        if (_phoneController.text.trim().isEmpty) {
                          _phoneError = 'Phone is required';
                        }
                        if (_usernameController.text.trim().isEmpty) {
                          _usernameError = 'Username is required';
                        }

                        if (_firstNameError == null &&
                            _lastNameError == null &&
                            _emailError == null &&
                            _phoneError == null &&
                            _usernameError == null) {
                          // Update profile info logic
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
