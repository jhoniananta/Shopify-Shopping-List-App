import 'package:flutter/material.dart';
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
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFEFEAFF),
            Color(0xFFCBC3E3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.2),
            blurRadius: 12,
            spreadRadius: 3,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Animated Checkbox
              GestureDetector(
                onTap: () => widget.onCheckboxChanged(!widget.isDone),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: widget.isDone ? const Color(0xFF7F56D9) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: widget.isDone ? const Color(0xFF7F56D9) : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: widget.isDone
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item Name
                  Text(
                    widget.item,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: widget.isDone ? Colors.grey[600] : Colors.black,
                      decoration: widget.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Quantity and Unit
                  Text(
                    '${widget.quantity} ${widget.unit}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: widget.isDone ? Colors.grey[500] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Delete Button
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.redAccent,
            splashRadius: 28,
            onPressed: widget.onDeletePressed,
          ),
        ],
      ),
    );
  }
}
