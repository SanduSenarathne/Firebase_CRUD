import 'package:crud_operations/CRUD/crud_operations_02.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

  CRUDoperations _CRUDoperations = CRUDoperations();
  CrudOperationsQR _crudOperationsQR = CrudOperationsQR();

  String _generatedQrData = '';
  String uid = '';

  @override
  void initState() {
    super.initState();
    generateQRData(); // Generate initial QR data when the page is loaded
  }

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
              SizedBox(height: 10),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _birthdayController,
                decoration: InputDecoration(
                  labelText: 'Birthday',
                ),
              ),
              SizedBox(height: 10),
              QrImageView(
                data: _generatedQrData,
                version: QrVersions.auto,
                size: 100.0,
              ),
              SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final name = _nameController.text;
                        final age = int.parse(_ageController.text);
                        final birthday =
                            DateTime.parse(_birthdayController.text);

                        _CRUDoperations.createUser(
                            name: name, age: age, birthday: birthday);
                        cleardata();
                      },
                      child: Text('Add Details'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        final name = _nameController.text;
                        final age = int.parse(_ageController.text);
                        final birthday =
                            DateTime.parse(_birthdayController.text);

                        final qrData =
                            'Name: $name\nAge: $age\nBirthday: $birthday\nTimestamp: ${DateTime.now().millisecondsSinceEpoch}';
                        setState(() {
                          _generatedQrData = qrData;
                          uid = qrData;
                        });

                        _crudOperationsQR.createUser(
                            uid: uid, name: name, age: age, birthday: birthday);
                        cleardata();
                      },
                      child: Text('Add Details with QR'),
                    ),
                  ],
                ),
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

  void generateQRData() {
    final initialData = 'Initial Data'; // can provide any initial data here
    setState(() {
      _generatedQrData = initialData;
    });
  }
}
