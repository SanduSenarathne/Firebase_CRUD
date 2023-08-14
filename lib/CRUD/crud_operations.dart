import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operations/Model/User.dart';

class CRUDoperations {
  //show list of the users inside the database
  Stream<List<User>> readUser() =>
      FirebaseFirestore.instance.collection('Users').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => User.fromJson(doc.data()),
                )
                .toList(),
          );

  //create a new User
  Future createUser(
      {required String name,
      required int age,
      required DateTime birthday}) async {
    //reference to document
    final docUser = FirebaseFirestore.instance.collection('Users').doc();

    final user = User(id: docUser.id, name: name, age: age, birthday: birthday);

    final json = user.toJson();

    //create document and write data to firebase
    await docUser.set(json);
  }
}
