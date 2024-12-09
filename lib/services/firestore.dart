import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/models/list.dart';
import 'package:shopify_shopping_list_app/screens/item_list.dart';
import 'package:shopify_shopping_list_app/models/account_model.dart';

class FirestoreService {
  final CollectionReference listCollection =
      FirebaseFirestore.instance.collection('lists');

  final CollectionReference accountCollection =
      FirebaseFirestore.instance.collection('account');

  Future<String> createList(ListItem listItem) async {
    try {
      DocumentReference _docRef = await listCollection.add(listItem.toMap());
      _docRef.update({'id': _docRef.id});

      return _docRef.id;
    } catch (e) {
      print(e);
      throw Exception("Failed to create list");
    }
  }

  Future<void> updateCheckboxItem(String id, int index, bool isDone) async {
    try {
      final docSnapshot = await listCollection.doc(id).get();
      final data = docSnapshot.data() as Map<String, dynamic>;
      final items = data['items'] as List<dynamic>;

      items[index]['isDone'] = !isDone;
      await listCollection.doc(id).update({'items': items});
    } catch (e) {
      print(e);
      throw Exception("Failed to update checkbox item");
    }
  }

  Stream<QuerySnapshot> getLists() {
    return listCollection.snapshots();
  }

  Stream<QuerySnapshot> getListById(String id) {
    return listCollection.where('id', isEqualTo: id).snapshots();
  }

  // Delete a list
  Future<void> deleteList(String id) async {
    try {
      await listCollection.doc(id).delete();
    } catch (e) {
      throw Exception("Failed to delete list");
    }
  }

  // Delete an item
  Future<void> deleteItem(String id, int index) async {
    try {
      final docSnapshot = await listCollection.doc(id).get();
      final data = docSnapshot.data() as Map<String, dynamic>;
      final items = data['items'] as List<dynamic>;

      items.removeAt(index);
      await listCollection.doc(id).update({'items': items});
    } catch (e) {
      print(e);
      throw Exception("Failed to delete item");
    }
  }

  // Accounts
  Future<void> updateAccount(
    String accountId, {
    String? name,
    String? email,
    String? phoneNumber,
    String? birthdayPlace,
    String? birthdayDate,
  }) async {
    try {
      Map<String, dynamic> updatedData = {};

      if (name != null) updatedData['name'] = name;
      if (email != null) updatedData['email'] = email;
      if (phoneNumber != null) updatedData['phoneNumber'] = phoneNumber;
      if (birthdayPlace != null) updatedData['birthdayPlace'] = birthdayPlace;
      if (birthdayDate != null) updatedData['birthdayDate'] = birthdayDate;

      await accountCollection.doc(accountId).update(updatedData);
    } catch (e) {
      throw Exception("Failed to update account: $e");
    }
  }

  Stream<List<Account>> getAccounts() {
    return accountCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Account.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<Map<String, int>> calculateStats() async {
    try {
      // Fetch all lists from Firestore
      QuerySnapshot listsSnapshot = await listCollection.get();

      int listMade = listsSnapshot.docs.length; // Total lists
      int listDone = 0;

      // Calculate lists where all items are done
      for (var doc in listsSnapshot.docs) {
        List<dynamic> items = doc['items'] ?? [];
        bool allItemsDone = items.every((item) => item['isDone'] == true);

        if (allItemsDone) {
          listDone++;
        }
      }

      // Return the calculated stats
      return {
        'listMade': listMade,
        'listDone': listDone,
      };
    } catch (e) {
      print('Error calculating stats: $e');
      return {
        'listMade': 0,
        'listDone': 0,
      };
    }
  }
}
