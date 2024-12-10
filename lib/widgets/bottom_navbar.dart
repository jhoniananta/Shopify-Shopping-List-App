// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// class BottomNavbar extends StatelessWidget {
//   const BottomNavbar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       // Memastikan Navbar hanya berada di area aman layar.
//       child: Container(
//         color: const Color(0xFFB692F6),
//         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
//         child: Row(
//           mainAxisAlignment:
//               MainAxisAlignment.spaceAround, // Pastikan ikon tersebar merata.
//           children: const [
//             NavigationItem(
//               iconPath: 'assets/navbar/list.png',
//               label: 'Lists',
//             ),
//             NavigationItem(
//               iconPath: 'assets/navbar/profile.png',
//               label: 'Profile',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NavigationItem extends StatelessWidget {
//   final String iconPath; // Path ke aset gambar lokal
//   final String label;

//   const NavigationItem({
//     Key? key,
//     required this.iconPath,
//     required this.label,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (label == 'Lists') {
//           Navigator.pushNamed(context, '/home');
//         } else {
//           Navigator.pushNamed(context, '/profile');
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize
//             .min, // Memastikan widget hanya mengambil ruang seminimal mungkin.
//         children: [
//           Image.asset(
//             iconPath,
//             width: 40,
//             height: 40,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(height: 5), // Memberi jarak antara ikon dan teks.
//           Text(
//             label,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 13,
//               fontFamily: 'Inter', // Menggunakan font Inter
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onItemTapped;

  const BottomNavbar({
    Key? key,
    required this.activeIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFF7F56D9),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavigationItem(
              iconPath: 'assets/navbar/list.png',
              label: 'Lists',
              isActive: activeIndex == 0,
              onTap: () => onItemTapped(0),
            ),
            NavigationItem(
              iconPath: 'assets/navbar/profile.png',
              label: 'Profile',
              isActive: activeIndex == 1,
              onTap: () => onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavigationItem({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
            opacity: isActive ? AlwaysStoppedAnimation(1) : AlwaysStoppedAnimation(0.5), 
            
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white70,
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              shadows: isActive
                  ? [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ]
                  : [],
            ),
          ),
        ],
      ),
    );
  }
}
