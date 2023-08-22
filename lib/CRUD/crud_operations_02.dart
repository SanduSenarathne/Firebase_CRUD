import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operations/Model/User_QR.dart';

class CrudOperationsQR {
  Future createUser(
      {required String uid,
      required String name,
      required int age,
      required DateTime birthday}) async {
    //reference to document
    final docUser = FirebaseFirestore.instance.collection('UsersQR').doc();

    // Create a new User instance
    final userQr = UserQR(uid: uid, name: name, age: age, birthday: birthday);

    final json = userQr.toJson();

    await docUser.set(json);
  }
}
