import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Profile picture
          ClipOval(
            child: Image.network(
              'https://via.placeholder.com/48',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          // Name and email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Anjali Arora',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Anjali@shreyansign.com',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          // Icons
          Row(
            children: [
              Icon(
                Icons.verified,
                color: Colors.purple,
                size: 24.0,
              ),
              const SizedBox(width: 16.0),
              Icon(
                Icons.notifications_none,
                color: Colors.grey,
                size: 24.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}