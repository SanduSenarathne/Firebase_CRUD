import 'package:crud_operations/addUsers.dart';
import 'package:crud_operations/updateUser.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'CRUD/crud_operations.dart';
import 'Model/User.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  /*Future<void> deleteUser(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.id)
          .delete();
      print('User deleted successfully.');
    } catch (error) {
      print('Error deleting user: $error');
    }
  }*/

  final CRUDoperations _cruDoperations = CRUDoperations();

  Widget buildUser(User user) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return ListTile(
      leading: CircleAvatar(child: Text(user.name[0])),
      title: Text(user.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Birthday: ${dateFormat.format(user.birthday)}'),
          Text('Age: ${user.age}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.green[700],
            onPressed: () {
              //  navigate to update page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => UpdateUser(userid: user.id)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red[700],
            onPressed: () async {
              // delete functionality
              await _cruDoperations.deleteUser(user);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        title: const Text(
          'All Users',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontSize: 30,
          ),
        ),
      ),
      body: StreamBuilder<List<User>>(
        stream: _cruDoperations.readUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong!${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[400],
      ),
    );
  }

  /*Stream<List<User>> readUser() =>
      FirebaseFirestore.instance.collection('Users').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => User.fromJson(doc.data()),
                )
                .toList(),
          );*/
}
