import 'package:flutter/material.dart';
import 'package:novalinguo/screens/home/bienvenue_screen.dart';
import 'package:novalinguo/screens/home/home_screen.dart';
import 'package:novalinguo/screens/home/profils2_screen.dart';
import 'package:novalinguo/screens/home/tchatArriere_screen.dart';
import 'package:novalinguo/screens/home/user_list.dart';

// Création du Bouton d'Aceuil
class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(254, 209, 72, 1),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      },
      child: Icon(
        Icons.home,
        color: Colors.black,
        size: 40,
      ),
    );
  }
}

// Création footerBar + Icons du footer
class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
      child: BottomAppBar(
        // avce l'argument "shape" je fait un espace enntre le bouton Acceuil
        // et la footerBar
        shape: CircularNotchedRectangle(),
        //Regler l'espace bouton et footerBar
        notchMargin: 25,
        //color: Color.fromRGBO(25, 26, 46, 1),
        child: Row(
          children: [
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 35,
                color: Color.fromRGBO(254, 209, 72, 1),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profils2(),
                  ),
                );
              },
            ),
            Spacer(),
            Spacer(),
            Spacer(),
            Spacer(),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.military_tech,
                color: Color.fromRGBO(254, 209, 72, 1),
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TchatArriere(),
                  ),
                );
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class FloatingLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Je place ensuite le Bouton au millieu
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Permet de voir les element de la page entre le bouton Acceuil et footerBar
      extendBody: true,
    );
  }
}
