import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify_shopping_list_app/models/list.dart';
import 'package:shopify_shopping_list_app/screens/item_list.dart';

class FirestoreService {
  final CollectionReference listCollection =
      FirebaseFirestore.instance.collection('lists');

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

  Stream<QuerySnapshot> getLists() {
    return listCollection.snapshots();
  }

  Stream<QuerySnapshot> getListById(String id) {
    return listCollection.where('id', isEqualTo: id).snapshots();
  }
}
