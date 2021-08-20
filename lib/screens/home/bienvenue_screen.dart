import 'package:flutter/material.dart';

class Bienvenue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 42, 75, 1),
      body: SafeArea(
        child: Container(
          width: size.width,
          margin: EdgeInsets.fromLTRB(40, 100, 40, 40),
          alignment: Alignment.topLeft,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bienvenue !",
                  style: TextStyle(color: Colors.white, fontSize: 30)),
              SizedBox(height: 25.0),
              Text(
                "Voici ton premier compagnon, tu vas pouvoir en débloquer d'autres au fur et à mesure de ton apprentissage à la langue anglais",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 40.0),
              Text(
                "Rends-toi dans la boutique pour voir les autres compagnons disponibles !",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 30.0),
              Center(
                child: Container(
                    height: 120,
                    width: size.width,
                    alignment: AlignmentDirectional.topEnd,
                    //alignment: Alignment.center,

                    child: Image.asset('images/tortue.png')),
              ),
              SizedBox(height: 40.0),
              Center(
                child: ClipRRect(
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
                        "OK !  ",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
