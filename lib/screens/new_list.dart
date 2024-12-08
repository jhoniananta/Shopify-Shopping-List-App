// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/models/list.dart';
import 'package:shopify_shopping_list_app/routes/routes_app.dart';
import 'package:shopify_shopping_list_app/services/firestore.dart';
import 'package:shopify_shopping_list_app/widgets/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    final _categoryController = TextEditingController();
    final FirestoreService _firestoreService = FirestoreService();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ProfileCard(),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        child: const Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Positioned(
                              bottom:
                                  -1, // Offset icon below the circle slightly
                              right:
                                  -1, // Offset icon to the right of the circle
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  FontAwesomeIcons.pencil,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 20),
                    Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'New List',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.fromLTRB(16, 16, 17, 16),
                        ),
                        style: const TextStyle(
                          fontSize: 14, // Ukuran teks
                          fontWeight: FontWeight.w800, // Berat teks
                          color: Colors.black, // Warna teks
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _categoryController,
                        decoration: InputDecoration(
                          labelText: 'Category',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.fromLTRB(16, 16, 17, 16),
                        ),
                        style: const TextStyle(
                          fontSize: 14, // Ukuran teks
                          fontWeight: FontWeight.w800, // Berat teks
                          color: Colors.black, // Warna teks
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final title = _titleController.text;
                      final category = _categoryController.text;
                      if (title.isNotEmpty && category.isNotEmpty) {
                        try {
                          final ListItem _listItem = ListItem(
                              category: category, title: title, items: []);
                          final id =
                              await _firestoreService.createList(_listItem);
                          Navigator.pushNamed(context, AppRoutes.itemList,
                              arguments: {"id": id});
                        } catch (e) {
                          print("Error Creating List $e");
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Please fill in all fields'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      'Create List',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 127, 86, 217)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Radius
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ]),
      )),
    );
  }
}
