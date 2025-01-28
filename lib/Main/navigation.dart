import 'package:adilco/Main/profile.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Center(
                    child: CircleAvatar(
                  backgroundImage: AssetImage('images/adilco-logo.jpg'),
                  radius: 50,
                )),
              ),
              const ListTile(
                leading: Icon(Icons.star, color: Colors.red),
                title: Text(
                  'View Points',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.red),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
              ),
              const ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Text(
            'Welcome to the Dashboard!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
