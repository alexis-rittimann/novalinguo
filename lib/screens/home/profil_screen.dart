import 'package:flutter/material.dart';
import 'package:novalinguo/common/bottomBar.dart';
import 'package:novalinguo/screens/authenticate/authenticate_screen.dart';
import 'package:novalinguo/services/user.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final UserService userSevice = UserService();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 42, 75, 1),
      body: Container(
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 50,
                width: 270,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "General conditions",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 50,
                width: 270,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Need help ?",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 50,
                width: 270,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Sign out",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 50,
                width: 270,
                child: TextButton(
                  onPressed: () async {
                    await userSevice.deleteUser();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AuthenticateScreen()));
                  },
                  child: Text(
                    "Delete account",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
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
