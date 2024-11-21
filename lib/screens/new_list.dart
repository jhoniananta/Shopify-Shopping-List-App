import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/widgets/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        child: Stack(
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
                  SizedBox(height: 20),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'New List',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        hintStyle: TextStyle(
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
                      style: TextStyle(
                        fontSize: 14, // Ukuran teks
                        fontWeight: FontWeight.w800, // Berat teks
                        color: Colors.black, // Warna teks
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
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
                  SizedBox(height: 35),
                ],
              ),
            ]),
      )),
    );
  }
}
