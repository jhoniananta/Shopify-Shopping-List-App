import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/widgets/bottom_navbar.dart';
import 'package:shopify_shopping_list_app/services/firestore.dart';
import 'package:shopify_shopping_list_app/widgets/item_card.dart';
import 'package:shopify_shopping_list_app/widgets/profile.dart';
import 'package:shopify_shopping_list_app/widgets/add_item_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemList extends StatefulWidget {
  final String id;

  const ItemList({
    super.key,
    required this.id,
  });

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final FirestoreService _firestoreService = FirestoreService();

  int currentIndex = 2;

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

  // Form key dan TextEditingController untuk pop-up
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  void _onEditItem(String newItem, int newQuantity, String newUnit, int index) {
    _firestoreService
        .updateItem(
      widget.id, // ID list belanja
      index, // Index item yang ingin diupdate
      newItem,
      newQuantity,
      newUnit,
    )
        .then((_) {
      print("Item updated successfully!");
    }).catchError((error) {
      print("Error updating item: $error");
    });
  }

  // Method untuk membuka pop-up dialog menggunakan AddItemPopup
  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddItemPopup(
          formKey: _formKey,
          nameController: _nameController,
          quantityController: _quantityController,
          unitController: _unitController,
          onSave: () {
            if (_formKey.currentState?.validate() ?? false) {
              _firestoreService.addItemToList(
                widget.id,
                {
                  "name": _nameController.text,
                  "quantity": int.parse(_quantityController.text),
                  "unit": _unitController.text,
                  "isDone": false,
                },
              );
              Navigator.of(context).pop();
              _nameController.clear();
              _quantityController.clear();
              _unitController.clear();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        title: ProfileCard(),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: _firestoreService.getListById(widget.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final _itemList = snapshot.data!.docs;

          if (_itemList.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border:
                          Border.all(color: Colors.grey.shade400, width: 0.5),
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
                          'Start by adding items',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Your items will show here. Start by adding a new item.',
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

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      _itemList[0]['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: _itemList[0]["items"].length,
                    itemBuilder: (context, index) {
                      final item = _itemList[0]["items"][index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ItemCard(
                          item: item["name"],
                          quantity: item["quantity"],
                          unit: item["unit"],
                          isDone: item["isDone"],
                          onDeletePressed: () {
                            _firestoreService.deleteItem(widget.id, index);
                          },
                          onEditPressed: (newItem, newQuantity, newUnit) {
                            _onEditItem(newItem, newQuantity, newUnit, index);
                          },
                          onCheckboxChanged: (bool? value) {
                            _firestoreService.updateCheckboxItem(
                              widget.id,
                              index,
                              item["isDone"],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        backgroundColor: Colors.grey.withOpacity(0.4),
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.purple,
          size: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavbar(
        activeIndex: currentIndex,
        onItemTapped: onTabTapped,
      ),
    );
  }
}