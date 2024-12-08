import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/models/list.dart';
import 'package:shopify_shopping_list_app/services/firestore.dart';
import 'package:shopify_shopping_list_app/widgets/item_card.dart';
import 'package:shopify_shopping_list_app/widgets/profile.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
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
                          print(index);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ItemCard(
                                item: item["name"],
                                quantity: item["quantity"],
                                unit: item["unit"],
                                isDone: item["isDone"],
                                onCheckboxChanged: (bool? value) {
                                  _firestoreService.updateCheckboxItem(
                                      widget.id, index, item["isDone"]);
                                }),
                          );
                        },
                      ),
                    ),
                    // ItemCard(item: _itemList[0]["items"][0]["name"]),
                  ],
                ),
              );
            }));
  }
}