// ignore_for_file: prefer_const_constructors

import '../data/account_data.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navbar.dart';

class MyProfile extends StatelessWidget {
  // final Account account;

  // MyProfile({required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Account',
            textAlign: TextAlign.left,
          ),
          actions: [
            TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xFF2A3663)),
                  overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.hovered)) {
                        return const Color(0xFFD8DBBD).withOpacity(0.04);
                      }
                      if (states.contains(WidgetState.focused) ||
                          states.contains(WidgetState.pressed)) {
                        return const Color(0xFFD8DBBD).withOpacity(0.20);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Edit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ))
          ],
        ),
        body: Container(
          height: 675,
          padding: EdgeInsets.fromLTRB(40, 20, 40, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: Center(
                        child: ClipOval(
                          child: Image.network(
                            'https://via.placeholder.com/75',
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      accounts[0].name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      accounts[0].email,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Tempat Lahir',
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: Text(
                    accounts[0].birthPlace,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Tanggal Lahir',
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: Text(
                    accounts[0].birthdayDate,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    'Nomor Telpon',
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: Text(
                    accounts[0].phoneNumber.toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      child: Card(
                        child: Column(
                          children: [
                            Center(child: Text('Jumlah List \nyang dibuat')),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(
                              accounts[0].listMade.toString(),
                              style: TextStyle(fontSize: 22),
                            ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Card(
                        child: Column(
                          children: [
                            Center(child: Text('Jumlah List \nyang selesai')),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(
                              accounts[0].listDone.toString(),
                              style: TextStyle(fontSize: 22),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
