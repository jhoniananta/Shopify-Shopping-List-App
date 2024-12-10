import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/services/firestore.dart';
import '../models/account_model.dart';
import '../widgets/bottom_navbar.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final FirestoreService _firestoreService = FirestoreService();
  int listMade = 0; // Total lists made
  int listDone = 0; // Total completed lists

  int currentIndex = 1;

  final List<String> routes = [
    '/home',
    '/profile',
  ];

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
  }

  Future<void> _fetchStats() async {
    // Fetch stats from Firestore
    final stats = await _firestoreService.calculateStats();
    setState(() {
      listMade = stats['listMade'] ?? 0;
      listDone = stats['listDone'] ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        title: Text(
          'Account',
          textAlign: TextAlign.left,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/editProfile');
            },
            child: const Text(
              'Edit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<Account>>(
        stream: _firestoreService.getAccounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No account data available.'));
          }

          // Assuming you want to display the first account
          final account = snapshot.data![0];

          return Container(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 110,
                        height: 110,
                        child: Center(
                          child: ClipOval(
                            child: Image.network(
                              'https://via.placeholder.com/110',
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        account.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        account.email,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Tempat Lahir', style: TextStyle(fontSize: 15)),
                    subtitle: Text(account.birthdayPlace,
                        style: TextStyle(fontSize: 15)),
                  ),
                ),
                Card(
                  child: ListTile(
                    title:
                        Text('Tanggal Lahir', style: TextStyle(fontSize: 15)),
                    subtitle: Text(account.birthdayDate,
                        style: TextStyle(fontSize: 15)),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Nomor Telpon', style: TextStyle(fontSize: 15)),
                    subtitle: Text(account.phoneNumber,
                        style: TextStyle(fontSize: 15)),
                  ),
                ),
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child: Card(
                          child: Column(
                            children: [
                              Center(child: Text('Jumlah List \nyang dibuat')),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  listMade
                                      .toString(), // Use dynamically calculated value
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Card(
                          child: Column(
                            children: [
                              Center(child: Text('Jumlah List \nyang selesai')),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  listDone
                                      .toString(), // Use dynamically calculated value
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
}
