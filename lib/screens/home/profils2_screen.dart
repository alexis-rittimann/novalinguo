import 'package:flutter/material.dart';

class Profils2 extends StatelessWidget {
  @override
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
                      "Condition générales d'utilisation",
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
                      "Besoin d'aide ?",
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
                      "Se déconnecter",
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
        ));
  }
}
