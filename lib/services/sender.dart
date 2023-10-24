import 'package:bussiness_alert_app/models/sender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SenderService {
  String collection = 'sender';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<SenderModel?> select(String? number) async {
    SenderModel? ret;
    await firestore
        .collection(collection)
        .where('number', isEqualTo: number ?? 'error')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        ret = SenderModel.fromSnapshot(value.docs.first);
      }
    });
    return ret;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamList() {
    return firestore
        .collection(collection)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
