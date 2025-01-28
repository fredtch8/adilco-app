import 'package:adilco/API/apiHandler.dart';
import 'package:adilco/Auth/login.dart';
import 'package:adilco/Models/Users.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _phoneError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPassError;

  ApiHandler apihandler = ApiHandler();

  void registerUser() async {
    final user = Users(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );

    try {
      await apihandler.registerUser(user);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User registered successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } catch (error) {
      // Handle errors from the API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $error'),
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
          'Register',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height, // Full screen height
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
                  'Create an Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please fill in the details below',
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
                    errorText: _firstNameError),
                const SizedBox(height: 20),
                _buildTextField(
                    label: 'Last Name',
                    myController: _lastNameController,
                    errorText: _lastNameError),
                const SizedBox(height: 20),
                _buildTextField(
                    label: 'Email',
                    myController: _emailController,
                    errorText: _emailError),
                const SizedBox(height: 20),
                _buildTextField(
                    label: 'Phone',
                    myController: _phoneController,
                    errorText: _phoneError),
                const SizedBox(height: 20),
                _buildTextField(
                    label: 'Username',
                    myController: _usernameController,
                    errorText: _usernameError),
                const SizedBox(height: 20),
                _buildPasswordField(
                    myController: _passwordController,
                    errorText: _passwordError,
                    label: 'Password',
                    isPasswordVisible: _isPasswordVisible,
                    onToggle: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    }),
                const SizedBox(height: 20),
                _buildPasswordField(
                    myController: _confirmPassController,
                    errorText: _confirmPassError,
                    label: 'Confirm Password',
                    isPasswordVisible: _isConfirmPasswordVisible,
                    onToggle: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    }),
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
                        _passwordError = null;
                        _confirmPassError = null;

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
                        if (_passwordController.text.trim().isEmpty) {
                          _passwordError = 'Password is required';
                        }
                        if (_confirmPassController.text.trim().isEmpty) {
                          _confirmPassError = 'Confirm Password is required';
                        }

                        if (_firstNameError == null &&
                            _lastNameError == null &&
                            _emailError == null &&
                            _phoneError == null &&
                            _usernameError == null &&
                            _passwordError == null &&
                            _confirmPassError == null) {
                          if (_passwordController.text.trim() !=
                              _confirmPassController.text.trim()) {
                            _confirmPassError = 'Passwords do not match';
                          } else {
                            //register user
                            registerUser();
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
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController myController,
      required String? errorText}) {
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
          errorText: errorText),
      style: const TextStyle(color: Colors.black87),
    );
  }

  Widget _buildPasswordField(
      {required String label,
      required bool isPasswordVisible,
      required VoidCallback onToggle,
      required TextEditingController myController,
      required String? errorText}) {
    return TextField(
      controller: myController,
      obscureText: !isPasswordVisible,
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
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.red,
            ),
            onPressed: onToggle,
          ),
          errorText: errorText),
      style: const TextStyle(color: Colors.black87),
    );
  }
}
