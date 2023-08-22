import 'package:cloud_firestore/cloud_firestore.dart';

class UserQR {
  String uid;
  final String name;
  final int age;
  final DateTime birthday;

  UserQR({
    required this.uid,
    required this.name,
    required this.age,
    required this.birthday,
  });
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'age': age,
        'birthday': birthday,
      };
  static UserQR fromJson(Map<String, dynamic> json) => UserQR(
        uid: json['uid'],
        name: json['name'],
        age: json['age'],
        birthday: (json['birthday'] as Timestamp).toDate(),
      );
}
