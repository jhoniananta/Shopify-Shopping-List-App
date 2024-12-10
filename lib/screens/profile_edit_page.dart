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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
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
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Account>>(
        stream: _firestoreService.getAccounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No account data available.'));
          }

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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profilepicture.png'),
                ),
                const SizedBox(height: 24),
                _buildInputField('Name', 'Enter your name', _nameController),
                _buildInputField('Email', 'Enter your email', _emailController,
                    keyboardType: TextInputType.emailAddress),
                _buildInputField('Birthplace', 'Enter your birthplace',
                    _birthdayPlaceController),
                _buildInputField(
                  'Birthdate',
                  'Enter your birth date',
                  _birthdayDateController,
                  keyboardType: TextInputType.datetime,
                ),
                _buildInputField('Phone Number', 'Enter your phone number',
                    _phoneNumberController,
                    keyboardType: TextInputType.phone),
                const SizedBox(height: 32),
                ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField(String label, String hint,
      TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
