import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operations/Model/User.dart';
//import 'package:flutter/material.dart';

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

    // Create a new User instance
    final user = User(id: docUser.id, name: name, age: age, birthday: birthday);

    // Convert the User instance to JSON format
    final json = user.toJson();

    //create document and write data to firebase
    await docUser.set(json);
  }

  //update user
  Future<void> updateUser(
      {required String id,
      required String name,
      required int age,
      required DateTime birthday}) async {
    // Reference to the existing document
    final docUser = FirebaseFirestore.instance.collection('Users').doc(id);

    final user = User(id: id, name: name, age: age, birthday: birthday);
    final json = user.toJson();

    // Update the existing document with the new data
    await docUser.update(json);
  }

  //Delating user
  Future<void> deleteUser(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.id)
          .delete();
      print('User deleted successfully.');
    } catch (error) {
      print('Error deleting user: $error');
    }
  }
}
