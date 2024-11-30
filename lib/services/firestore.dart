import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _listCollection = FirebaseFirestore.instance.collection('lists');

  Future<void> createList(String name) async {
    try {
      await _listCollection.add({'name': name});
    } catch (e) {
      print(e);
    }
  }
}
