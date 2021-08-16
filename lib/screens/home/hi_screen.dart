import 'package:flutter/material.dart';

class Hi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 42, 75, 1),
      body: Container(
        child: Column(
          children: [
            Text(
              "HI !",
              style: TextStyle(color: Colors.white),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: Column(
                  children: [
                    Text(
                      "Bienvenue sur...",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10.0),
                    Text.rich(
                      TextSpan(
                        text: "L'application qui te permet ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "d'apprendre l'anglais ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                "en parlant avec des personnes du même niveau que toi ! ",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Text(
                        "Chaque jour tu vas pouvoir communiquer avec une personne différente à propos du thème du jour."),
                    SizedBox(height: 10.0),
                    Text.rich(
                      TextSpan(
                        text: "Un ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "thème par jour ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "avec des défies, Et des  ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: "récompenses à gagner !",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 50,
                width: 170,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(131, 133, 238, 1),
                    ),
                  ),
                  icon: Text(
                    "OK !",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: "Raleway"),
                  ),
                  label: Icon(
                    Icons.east,
                    color: Colors.black,
                    size: 40.0,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
