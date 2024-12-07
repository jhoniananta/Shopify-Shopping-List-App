import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopify_shopping_list_app/models/list.dart';

class FirestoreService {
  final CollectionReference _listCollection =
      FirebaseFirestore.instance.collection('lists');

  Future<void> createList(ListItem listItem) async {
    try {
      DocumentReference _docRef = await _listCollection.add(listItem.toMap());
      _docRef.update({'id': _docRef.id});
    } catch (e) {
      print(e);
    }
  }
}
