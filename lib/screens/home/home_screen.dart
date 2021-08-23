import 'package:flutter/material.dart';
import 'package:novalinguo/models/user.dart';
import 'package:novalinguo/screens/home/user_list.dart';
import 'package:novalinguo/services/authentication.dart';
import 'package:novalinguo/services/database.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) throw Exception("user not found");
    final database = DatabaseService(user.uid);
    return StreamProvider<List<AppUserData>>.value(
      initialData: [],
      value: database.users,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          elevation: 0.0,
          title: Text('novalinguo'),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text('logout', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: UserList(),
      ),
    );
  }
}
