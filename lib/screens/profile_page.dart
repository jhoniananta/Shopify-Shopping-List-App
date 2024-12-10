import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/services/firestore.dart';
import '../models/account_model.dart';
import '../widgets/bottom_navbar.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> with SingleTickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  int listMade = 0; // Total lists made
  int listDone = 0; // Total completed lists

  int currentIndex = 1;
  final List<String> routes = ['/home', '/profile'];

  late AnimationController _controller;
  late Animation<double> fadeAnimation;

  void onTabTapped(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
      Navigator.pushReplacementNamed(context, routes[index]);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchStats(); // Fetch list statistics on initialization

    // Animation setup
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  Future<void> _fetchStats() async {
    final stats = await _firestoreService.calculateStats();
    setState(() {
      listMade = stats['listMade'] ?? 0;
      listDone = stats['listDone'] ?? 0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/editProfile');
            },
            icon: const Icon(Icons.settings, color: Colors.black),
          ),
        ],
      ),
      body: StreamBuilder<List<Account>>(
        stream: _firestoreService.getAccounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No account data available.'));
          }

          final account = snapshot.data![0];

          return FadeTransition(
            opacity: fadeAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profilepicture.png'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    account.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    account.email,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.grey[300], thickness: 1),
                  const SizedBox(height: 16),
                  _buildInfoCard('Tempat Lahir', account.birthdayPlace),
                  _buildInfoCard('Tanggal Lahir', account.birthdayDate),
                  _buildInfoCard('Nomor Telepon', account.phoneNumber),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey[300], thickness: 1),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard('Lists Created', listMade),
                      _buildStatCard('Lists Completed', listDone),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavbar(
        activeIndex: currentIndex,
        onItemTapped: onTabTapped,
      ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, int value) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
