import 'package:flutter/material.dart';

import 'CRUD/crud_operations.dart';
import 'Model/User.dart';

class UpdateUserPopup extends StatelessWidget {
  final User user;

  UpdateUserPopup({required this.user});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController =
        TextEditingController(text: user.name);
    TextEditingController _ageController =
        TextEditingController(text: user.age.toString());
    TextEditingController _birthdayController =
        TextEditingController(text: user.birthday.toString());

    CRUDoperations _CRUDoperations = CRUDoperations();

    return AlertDialog(
      title: Text('Update User Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _ageController,
            decoration: InputDecoration(labelText: 'Age'),
          ),
          TextField(
            controller: _birthdayController,
            decoration: InputDecoration(labelText: 'Birthday'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            final updateName = _nameController.text;
            final updateAge = int.tryParse(_ageController.text) ?? 0;
            final updateBirthday = DateTime.parse(_birthdayController.text);

            _CRUDoperations.updateUser(
                id: user.id,
                name: updateName,
                age: updateAge,
                birthday: updateBirthday);
            Navigator.of(context).pop();
          },
          child: Text('Update'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the pop-up
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
