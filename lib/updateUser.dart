import 'package:crud_operations/Model/User.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key, required this.userid}) : super(key: key);

  final String userid;

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _birthdayController = TextEditingController();

  late DatabaseReference dref;

  @override
  void initState() {
    super.initState();
    dref = FirebaseDatabase.instance.ref().child('Users');
    getUserData();
  }

  void getUserData() async {
    try {
      DataSnapshot snapshot =
          (await dref.child(widget.userid).once()) as DataSnapshot;
      Map<dynamic, dynamic>? user = snapshot.value as Map?;

      if (user != null) {
        print("Retrieved user data: $user");
        _nameController.text = user['name'];
        _ageController.text =
            user['age'].toString(); // Set other fields as well
        _birthdayController.text = user['birthday'];
      } else {
        print("User data not found.");
      }
    } catch (error) {
      print("Error fetching user data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        title: const Text(
          'Update User',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                //loadDetails();
              ),
              SizedBox(height: 20),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _birthdayController,
                decoration: InputDecoration(
                  labelText: 'Birthday',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  /*final name = _nameController.text;
                  final age = int.parse(_ageController.text);
                  final birthday = DateTime.parse(_birthdayController.text);
                  _cruDoperations.createUser(
                      name: name, age: age, birthday: birthday);
                  cleardata();*/
                },
                child: Text('Update Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*void pageLoad(){
    _nameController.text=User.fromJson(json)
  }*/
}
