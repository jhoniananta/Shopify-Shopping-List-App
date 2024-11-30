import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopify_shopping_list_app/widgets/bottom_navbar.dart';
import 'package:shopify_shopping_list_app/widgets/floating_action_bar.dart';
import 'package:shopify_shopping_list_app/widgets/list_card.dart';
import '../widgets/profile.dart';

class HomeListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: ProfileCard(),
      ),
      backgroundColor: Colors.white,
      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         padding: const EdgeInsets.all(16.0),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(16.0),
      //           border: Border.all(color: Colors.grey.shade400, width: 0.5),
      //         ),
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             // Placeholder image
      //             SvgPicture.asset(
      //               'assets/home_assets/home_screen.svg',
      //               height: 150,
      //               width: 150,
      //               fit: BoxFit.cover,
      //             ),
      //             const SizedBox(height: 16.0),
      //             // Title text
      //             const Text(
      //               'Start by creating list',
      //               style: TextStyle(
      //                 fontSize: 18.0,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.black,
      //               ),
      //             ),
      //             const SizedBox(height: 8.0),
      //             // Subtitle text
      //             const Text(
      //               'Your smart shopping list will show here. Start by creating a new list.',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 14.0,
      //                 color: Colors.grey,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(left:100,),
      //         child: SvgPicture.asset(
      //           'assets/home_assets/hand_drawn_arrow.svg',
      //           height: 150,
      //           width: 150,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: CardShoppingList(
        title: "Grocery Shopping List",
        subtitle: "List 1/7 Completed",
        tag: "Kitchen items",
        userImages: ("assets/navbar/profile.png"),
        onFavoritePressed: () {
          print("Favorite button pressed!");
        },
      ),
      floatingActionButton: CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const BottomNavbar()
    );
  }
}