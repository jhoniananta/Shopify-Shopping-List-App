import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[50]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(value: false, onChanged: (bool? value) {}),
              Text(
                'Beef Slice',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                )
                ),
            ],
          ),
          Icon(Icons.delete, color: Colors.red),
        ],
      ),
    );
  }
}
