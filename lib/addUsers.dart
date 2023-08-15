import 'package:flutter/material.dart';

import 'CRUD/crud_operations.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _birthdayController = TextEditingController();

  CRUDoperations _cruDoperations = CRUDoperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        title: const Text(
          'Add new Users',
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
                  final name = _nameController.text;
                  final age = int.parse(_ageController.text);
                  final birthday = DateTime.parse(_birthdayController.text);
                  _cruDoperations.createUser(
                      name: name, age: age, birthday: birthday);
                  cleardata();
                },
                child: Text('Add Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void cleardata() {
    _ageController.text = '';
    _nameController.text = '';
    _birthdayController.text = '';
  }

  /*Future createUser(
      {required String name,
      required int age,
      required DateTime birthday}) async {
    //reference to document
    final docUser = FirebaseFirestore.instance.collection('Users').doc();

    final user = User(id: docUser.id, name: name, age: age, birthday: birthday);

    final json = user.toJson();

    //create document and write data to firebase
    await docUser.set(json);
  }*/
}
