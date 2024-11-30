import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopify_shopping_list_app/widgets/item_card.dart';
import 'package:shopify_shopping_list_app/widgets/profile.dart';

class ItemList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ProfileCard(),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        child: Column(
          children: [
            ItemCard(),
          ],
        ),
      ),
    );
  }
}