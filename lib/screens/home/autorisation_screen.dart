import 'package:flutter/material.dart';

class AutorisationNotif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 42, 75, 1),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.only(top: 150),
          //alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 100, 20, 20),
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                      text: "Nous aimerions t'envoyer ",
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                            text: "des notifications ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: "lorsque tu recevras ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "des messages ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
              Column(
                children: [
                  TextButton.icon(
                    style: ButtonStyle(),
                    icon: Text("Autoriser"),
                    label: Icon(Icons.east),
                    onPressed: () {},
                  ),
                  TextButton.icon(
                    style: ButtonStyle(),
                    icon: Text("Refuser"),
                    label: Icon(Icons.east),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
