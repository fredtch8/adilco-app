import 'package:adilco/API/apiHandler.dart';
import 'package:adilco/Main/changePass.dart';
import 'package:adilco/Auth/login.dart';
import 'package:adilco/secureStorage.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer
import 'profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ApiHandler apihandler = ApiHandler();

  Future<String?> getToken() async {
    return await SecureStorage.read('auth_token');
  }

  Future<void> logout() async {
    String? token = await getToken();
    final response = await apihandler.logout(token);
    if (response.statusCode == 200) {
      // Successfully logged out
      print('Logout successful');
      await SecureStorage.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      // Error logging out
      print('Error: ${response.body}');
    }
  }

  // Dummy data for the slider images
  final List<String> sliderImages = [
    'images/welcome.webp',
    'images/special-offer.webp',
  ];

  // PageController for the image slider
  final PageController _pageController = PageController(initialPage: 0);

  // Timer for automatic scrolling
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start automatic scrolling
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    _pageController.dispose(); // Dispose the PageController
    super.dispose();
  }

  // Method to start automatic scrolling
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page == sliderImages.length - 1) {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF5252),
        foregroundColor: const Color(0xFFF5F5F5),
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
              colors: [Color(0xFFF5F5F5), Color(0xFFF5F5F5)],
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
                  ),
                ),
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
              ListTile(
                leading: const Icon(
                  Icons.lock,
                  color: Colors.red,
                ),
                title: const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                onTap: () {
                  logout();
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFCE4EC), Color(0xFFF5F5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Slider using PageView
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: sliderImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        image: DecorationImage(
                          image: AssetImage(sliderImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Adilco Logo
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(10),
              //       child: const CircleAvatar(
              //         backgroundImage: AssetImage('images/adilco-logo.jpg'),
              //         radius: 50,
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 20),

              // Loyalty Points Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.waving_hand, color: Colors.amber, size: 40),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, Freddy!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Loyalty Points: 500',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Categories Menu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shop by Category',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 12, // Spacing between columns
                      mainAxisSpacing: 12, // Spacing between rows
                      children: [
                        _buildCategoryItem(Icons.shopping_basket, 'Fruits'),
                        _buildCategoryItem(Icons.local_drink, 'Beverages'),
                        _buildCategoryItem(Icons.emoji_food_beverage, 'Snacks'),
                        _buildCategoryItem(Icons.clean_hands, 'Cleaning'),
                        _buildCategoryItem(Icons.kitchen, 'Kitchen'),
                        _buildCategoryItem(Icons.medical_services, 'Health'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // New Arrivals & Best Sellers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'New Arrivals',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildProductItem(
                              'Black Label', 'images/black-label.webp'),
                          _buildProductItem(
                              'Chivas 18', 'images/chivas-18.jpeg'),
                          _buildProductItem(
                              'Terea Siver', 'images/terea-silver.jpeg'),
                          _buildProductItem(
                              'Terea Siver', 'images/terea-silver.jpeg'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Best Sellers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildProductItem(
                              'Black Label', 'images/black-label.webp'),
                          _buildProductItem(
                              'Chivas 18', 'images/chivas-18.jpeg'),
                          _buildProductItem(
                              'Terea Siver', 'images/terea-silver.jpeg'),
                          _buildProductItem(
                              'Terea Siver', 'images/terea-silver.jpeg'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build category items
  Widget _buildCategoryItem(IconData icon, String label) {
    return Card(
      elevation: 4, // Adds a shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(12), // Inner padding
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers content vertically
          children: [
            Container(
              padding: const EdgeInsets.all(12), // Padding around the icon
              decoration: BoxDecoration(
                color: Colors.red
                    .withOpacity(0.1), // Light background for the icon
                shape: BoxShape.circle, // Circular shape for the icon container
              ),
              child: Icon(
                icon,
                size: 32, // Icon size
                color: Colors.red, // Icon color
              ),
            ),
            const SizedBox(height: 8), // Spacing between icon and text
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center, // Centers the text
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build product items
  Widget _buildProductItem(String name, String imageUrl) {
    return Card(
      elevation: 4, // Adds a shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Container(
        width: 140, // Fixed width for each product item
        padding: const EdgeInsets.all(3), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Container
            Container(
              height: 100, // Adjusted height for the image container
              width: double.infinity, // Takes the full width of the card
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    8), // Rounded corners for the image container
                image: DecorationImage(
                  image: AssetImage(imageUrl), // Use NetworkImage for URLs
                  fit: BoxFit
                      .cover, // Ensures the image covers the entire container
                ),
              ),
            ),
            const SizedBox(height: 2), // Spacing between image and text
            // Product Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 2, // Limits the text to 2 lines
              overflow:
                  TextOverflow.ellipsis, // Adds ellipsis if the text overflows
            ),
          ],
        ),
      ),
    );
  }
}
