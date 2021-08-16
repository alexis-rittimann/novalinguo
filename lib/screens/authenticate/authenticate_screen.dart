import 'package:flutter/material.dart';
import 'package:novalinguo/common/constants.dart';
import 'package:novalinguo/common/loading.dart';
import 'package:novalinguo/services/authentication.dart';

class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      emailController.text = '';
      nameController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color.fromRGBO(41, 42, 75, 1),
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(25, 26, 46, 1),
              elevation: 0.0,
              title: Text(showSignIn
                  ? 'Sign in to novalinguo'
                  : 'Register to novalnguo'),
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(showSignIn ? "Register" : 'Sign In',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () => toggleView(),
                ),
              ],
            ),

            // LE BODY #############################################################
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      //padding: EdgeInsets.all(20),
                      alignment: Alignment.topLeft,
                      height: 20,
                      child: IconButton(
                        icon: Icon(Icons.west),
                        iconSize: 50.0,
                        color: Color.fromRGBO(131, 133, 238, 1),
                        onPressed: () => toggleView(),
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      //padding: EdgeInsets.all(20),
                      //height: 150,
                      child: Text(
                        /*
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        */
                        showSignIn ? 'Connexion' : 'Inscription',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(height: 35.0),
                    !showSignIn
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: TextFormField(
                              controller: nameController,
                              decoration:
                                  textInputDecoration.copyWith(hintText: 'Nom'),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Enter a name"
                                      : null,
                            ),
                          )
                        : Container(),
                    !showSignIn ? SizedBox(height: 10.0) : Container(),

                    SizedBox(height: 20.0),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: TextFormField(
                        controller: emailController,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Adresse mail'),
                        validator: (value) => value == null || value.isEmpty
                            ? "Enter an email"
                            : null,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Mot de passe'),
                        obscureText: true,
                        validator: (value) => value != null && value.length < 6
                            ? "Enter a password with at least 6 characters"
                            : null,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    !showSignIn
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: TextFormField(
                              controller: nameController,
                              decoration:
                                  textInputDecoration.copyWith(hintText: 'Âge'),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Âge requis 15 ans"
                                      : null,
                            ),
                          )
                        : Container(),
                    !showSignIn ? SizedBox(height: 10.0) : Container(),

                    //SizedBox(height: 30.0),
                    !showSignIn
                        ? Row(children: <Widget>[
                            Checkbox(
                              value: true,
                              onChanged: (value) {
                                setState(() {
                                  value = _value;
                                });
                              },
                              activeColor: Colors.white,
                            ),
                            // Expanded() permet de pas dépasser l'espace du telephone
                            Expanded(
                              child: Text(
                                "J'accepte les conditions générales d'utilisation",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: "Raleway"),
                              ),
                            )
                          ])
                        : Container(),
                    SizedBox(height: 20.0),
                    // BOUTON SUIVANT #####################################################
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
                            "Suivant",
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
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              setState(() => loading = true);
                              var password = passwordController.value.text;
                              var email = emailController.value.text;
                              var name = nameController.value.text;

                              dynamic result = showSignIn
                                  ? await _auth.signInWithEmailAndPassword(
                                      email, password)
                                  : await _auth.registerWithEmailAndPassword(
                                      name, email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Please supply a valid email';
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    !showSignIn
                        ? Column(
                            children: [
                              Text(
                                "Déjà inscrit ?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: "Raleway"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Connecte-toi",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontFamily: "Raleway"),
                                  ),
                                  TextButton(
                                    child: Text("JUSTE ICI !",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                254, 209, 72, 1))),
                                    onPressed: () => toggleView(),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(),

                    SizedBox(height: 10.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 15.0),
                    )
                  ],
                ),
              ),
            ),

            // LE FOOTER #######################################################

            // Création du Bouton d'Aceuil
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromRGBO(254, 209, 72, 1),
              onPressed: () {},
              child: Icon(
                Icons.home,
                color: Colors.black,
                size: 40,
              ),
            ),
            // Je place ensuite le Bouton au millieu
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            // Permet de voir les element de la page entre le bouton Acceuil et footerBar
            extendBody: true,

            // Création footerBar + Icons du footer
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              child: BottomAppBar(
                // avce l'argument "shape" je fait un espace enntre le bouton Acceuil
                // et la footerBar
                shape: CircularNotchedRectangle(),
                //Regler l'espace bouton et footerBar
                notchMargin: 15,
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
                      onPressed: () {},
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
                        size: 35,
                      ),
                      onPressed: () {},
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
  }
}
