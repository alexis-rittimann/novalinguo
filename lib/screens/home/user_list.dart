import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novalinguo/common/bottomBar.dart';
import 'package:novalinguo/models/chat_params.dart';
import 'package:novalinguo/models/user.dart';
import 'package:novalinguo/services/database.dart';
import 'package:novalinguo/services/user.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<AppUserData>>(context);
    // final user = Provider.of<User?>(context);
    final currentUser = Provider.of<AppUser?>(context);
    final DatabaseService databaseService = DatabaseService(currentUser!.uid);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 300.0, horizontal: 30.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(131, 133, 238, 1),
                    ),
                  ),
                  icon: Text(
                    'Search a partner',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: 'Raleway'),
                  ),
                  label: Icon(
                    Icons.east,
                    color: Colors.black,
                    size: 40.0,
                  ),
                  onPressed: () async {
                    databaseService.connectToChat();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingButton(),
      bottomNavigationBar: BottomNavigation(),
      // Je place ensuite le Bouton au millieu
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Permet de voir les element de la page entre le bouton Acceuil et footerBar
      extendBody: true,
    );
  }
}

class UserTile extends StatelessWidget {
  final AppUserData user;
  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");
    return GestureDetector(
        onTap: () {
          if (currentUser.uid == user.uid || user.isConnected == false)
            return; // verification si l'utilisateur a appuié sur le bouton et si uid est pas égale à currentUser
          Navigator.pushNamed(
            context,
            '/chat',
            arguments: ChatParams(currentUser.uid, user),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.only(
                top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
            child: ListTile(
              title: Text(user.name),
              subtitle: Text('il est trop chaud pour ${user.age} ans'),
            ),
          ),
        ));
  }
}
