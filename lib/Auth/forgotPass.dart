import 'package:adilco/Auth/forgotPass2.dart';
import 'package:flutter/material.dart';

class forgotPass extends StatefulWidget {
  @override
  _forgotPassState createState() => _forgotPassState();
}

class _forgotPassState extends State<forgotPass> {
  final TextEditingController _emailPhoneController = TextEditingController();
  String? _errorMessage;

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
                          //if yes send the OTP to user email or phone
                          //if successfully sent go to next page

                          // Navigate to the second page if valid
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => forgotPass2(
                                      emailOrPhone: _emailPhoneController.text,
                                    )),
                          );
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
