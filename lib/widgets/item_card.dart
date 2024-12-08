// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/models/list.dart';
import 'package:shopify_shopping_list_app/services/firestore.dart';

class ItemCard extends StatefulWidget {
  final String item;
  final int quantity;
  final String unit;
  final bool isDone;
  final Function(bool?) onCheckboxChanged;
  final VoidCallback? onDeletePressed;

  
  const ItemCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.unit,
    required this.isDone,
    required this.onCheckboxChanged,
    this.onDeletePressed,
  });
  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  FirestoreService _firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey[200]!,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[50]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(value: widget.isDone, onChanged: widget.onCheckboxChanged),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.item,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      )),
                  Text('${widget.quantity} ${widget.unit}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              )
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.delete, 
              color: Colors.red
            ),
            onPressed: widget.onDeletePressed,
          )
        ],
      ),
    );
  }
}
