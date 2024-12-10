// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopify_shopping_list_app/widgets/bottom_navbar.dart';
import 'package:shopify_shopping_list_app/widgets/floating_action_bar.dart';
import 'package:shopify_shopping_list_app/widgets/list_card.dart';
import '../widgets/profile.dart';

class HomeListPage extends StatefulWidget {
  @override
  State<HomeListPage> createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  final FirestoreService _firestoreService = FirestoreService();

  int currentIndex = 0;

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: ProfileCard(),
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.getLists(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 0.5),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/home_assets/home_screen.svg',
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 16.0),
                              const Text(
                                'Start by creating list',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              const Text(
                                'Your smart shopping list will show here. Start by creating a new list.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: SvgPicture.asset(
                            'assets/home_assets/hand_drawn_arrow.svg',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                // Shopping list data from firebase
                final shoppingList = snapshot.data!.docs;

                // Method to count done items
                int countDoneItems(List<dynamic> items) {
                  return items.where((item) => item['isDone'] == true).length;
                }

                // List view of shopping list cards
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: shoppingList.length,
                  itemBuilder: (context, index) {
                    final listItem = shoppingList[index];
                    final items = listItem['items'] as List<dynamic>;
                    final doneItems = countDoneItems(items);
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/itemList',
                        arguments: {'id': listItem.id},
                      ),
                      child: CardShoppingList(
                        title: listItem['title'] ?? 'No title',
                        subtitle:
                            'List $doneItems/${listItem['items'].length} Completed',
                        tag: listItem['category'] ?? 'No category',
                        userImages: ("assets/navbar/profile.png"),
                        onDeletePressed: () async {
                          await _firestoreService.deleteList(listItem.id);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavbar(
        activeIndex: currentIndex,
        onItemTapped: onTabTapped,
      ),
    );
  }
}
