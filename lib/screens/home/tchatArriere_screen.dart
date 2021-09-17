import 'package:flutter/material.dart';
import 'package:novalinguo/common/bottomBar.dart';

class TchatArriere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 42, 75, 1),
      body: Container(
        width: size.width,
        margin: EdgeInsets.fromLTRB(25, 150, 25, 25),
        //color: Colors.purple,
        alignment: Alignment.topLeft,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thème du jour",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            Container(
              child: Image.asset('assets/images/Designer.png'),
              height: 180,
              width: size.width,
              margin: EdgeInsets.all(30),
            ),
            Text(
              "Mots du jour",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 20.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text("cute"),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            primary: Color.fromRGBO(242, 243, 244, 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            //elevation: 10,
                            //minimumSize: Size(10, 50),
                            //shadowColor: Colors.teal,
                            /*textStyle: TextStyle(
                                  //fontSize: 20,
                                  //fontStyle: FontStyle.italic,
                                  //fontFamily: "alex",
                            ),*/
                          ),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          child: Text("beautiful day"),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            primary: Color.fromRGBO(242, 243, 244, 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text("nightmare"),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            primary: Color.fromRGBO(131, 133, 238, 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          child: Text("journey"),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            primary: Color.fromRGBO(242, 243, 244, 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text("hair"),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            primary: Color.fromRGBO(242, 243, 244, 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          child: Text("hello i'm marjorie"),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            primary: Color.fromRGBO(242, 243, 244, 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text("hahahaha"),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            primary: Color.fromRGBO(242, 243, 244, 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          child: Text("good day"),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            primary: Color.fromRGBO(131, 133, 238, 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
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
