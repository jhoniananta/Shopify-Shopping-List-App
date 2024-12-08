import 'package:flutter/material.dart';

class CardShoppingList extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tag;
  final String userImages;
  final VoidCallback? onFavoritePressed;

  const CardShoppingList({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.userImages,
    this.onFavoritePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: SizedBox(
          height: 165,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.purple,
                      ),
                      onPressed: onFavoritePressed,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                   children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(userImages),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        subtitle,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.list, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.label, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          tag,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}