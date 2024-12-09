import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/services/firestore.dart';
import '../models/account_model.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirestoreService _firestoreService = FirestoreService();

  // Controllers for TextFields
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _birthdayDateController;
  late TextEditingController _birthdayPlaceController;
  late TextEditingController _phoneNumberController;

  @override
  void dispose() {
    // Dispose of controllers when the widget is destroyed
    _nameController.dispose();
    _emailController.dispose();
    _birthdayDateController.dispose();
    _birthdayPlaceController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Edit Account',
          textAlign: TextAlign.left,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // Save changes to Firestore
              await _firestoreService.updateAccount(
                'rm1l6aWe0EPb9dPqCpGO', // Replace with the actual account ID
                name: _nameController.text,
                email: _emailController.text,
                birthdayDate: _birthdayDateController.text,
                birthdayPlace: _birthdayPlaceController.text,
                phoneNumber: _phoneNumberController.text,
              );
              Navigator.pop(context); // Go back to the previous page
            },
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Account>>(
        stream: _firestoreService.getAccounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No account data available.'));
          }

          // Load the first account
          final account = snapshot.data![0];

          // Initialize controllers with account data
          _nameController = TextEditingController(text: account.name);
          _emailController = TextEditingController(text: account.email);
          _birthdayDateController =
              TextEditingController(text: account.birthdayDate);
          _birthdayPlaceController =
              TextEditingController(text: account.birthdayPlace);
          _phoneNumberController =
              TextEditingController(text: account.phoneNumber);

          return Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    title: Text('Nama', style: TextStyle(fontSize: 15)),
                    subtitle: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Email', style: TextStyle(fontSize: 15)),
                    subtitle: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Tempat Lahir', style: TextStyle(fontSize: 15)),
                    subtitle: TextField(
                      controller: _birthdayPlaceController,
                      decoration: InputDecoration(
                        hintText: 'Enter your birthplace',
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title:
                        Text('Tanggal Lahir', style: TextStyle(fontSize: 15)),
                    subtitle: TextField(
                      controller: _birthdayDateController,
                      decoration: InputDecoration(
                        hintText: 'Enter your birth date',
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Nomor Telpon', style: TextStyle(fontSize: 15)),
                    subtitle: TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
