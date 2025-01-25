import 'package:adilco/Auth/login.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.black,
        elevation: 1.0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 70,
          ),
          const Image(image: AssetImage('images/adilco-logo.jpg')),
          const SizedBox(
            height: 70,
          ),
          // Full Name
          const TextField(
            cursorColor: Colors.red,
            decoration: InputDecoration(
              labelText: 'Full Name',
              labelStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors
                      .red, // Border color when the TextField is not focused
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      Colors.red, // Border color when the TextField is focused
                  width: 2.0,
                ),
              ),
            ),
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Email
          const TextField(
            cursorColor: Colors.red,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors
                      .red, // Border color when the TextField is not focused
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      Colors.red, // Border color when the TextField is focused
                  width: 2.0,
                ),
              ),
            ),
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Password
          const TextField(
            cursorColor: Colors.red,
            obscureText: true, // Makes the password input hidden
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors
                      .red, // Border color when the TextField is not focused
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      Colors.red, // Border color when the TextField is focused
                  width: 2.0,
                ),
              ),
            ),
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Confirm Password
          const TextField(
            cursorColor: Colors.red,
            obscureText: true, // Makes the password input hidden
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              labelStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors
                      .red, // Border color when the TextField is not focused
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      Colors.red, // Border color when the TextField is focused
                  width: 2.0,
                ),
              ),
            ),
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Register Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red, // Button color
            ),
            child: const Text("Register"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You have an account? ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
