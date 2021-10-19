import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:novalinguo/common/constants.dart';
import 'package:novalinguo/common/loading.dart';
import 'package:novalinguo/screens/authenticate/reset.dart';
import 'package:novalinguo/services/authentication.dart';
//import 'package:novalinguo/common/bottomBar.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool isChecked = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  bool showSignIn = true; //permet de switcher de formulaire
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    // ageController.dispose();
    super.dispose();
  }

// sélectionne la date et thème du widget
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: Color.fromRGBO(41, 42, 75, 1),
                onPrimary: Color.fromRGBO(254, 209, 72, 1),
              ),
            ),
            child: child!,
          );
        });

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
      if (isAdult(formattedDate)!) {
        setState(() {
          ageController.text = formattedDate.toString();
        });
        // var date =
        //     '${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}';
        // Timestamp DatetoTimeStamp = Timestamp.fromDate(selectedDate);

        // selectedDate = selectedDate.toString(); // la variable date est envoyé à firestore
      }
    }
  }

  bool? isAdult(formattedDate) {
    DateTime today = DateTime.now();
    DateTime birthDate = DateFormat('dd-MM-yyyy').parse(formattedDate);
    ;
    // Date check
    DateTime adultDate = DateTime(
      birthDate.year + 16,
      birthDate.month,
      birthDate.day,
    );

    if (adultDate.isAfter(today)) {
      error = "16 yo";
    }

    return adultDate.isBefore(today);
  }

  void toggleView() {
    //permet de changer le showSignIn et rendre le form propre
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      emailController.text = '';
      nameController.text = '';
      passwordController.text = '';
      ageController.text = '';
      showSignIn = !showSignIn;
    });
  }

  final passwordValidatorSignUp = MultiValidator([
    RequiredValidator(errorText: 'Enter a password'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-.])',
        errorText: 'Password must have at least one special character')
  ]);

  final passwordValidatorSignIn = MultiValidator([
    RequiredValidator(errorText: 'Enter a password'),
  ]);

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Enter a name'),
    MaxLengthValidator(20, errorText: 'Name is too long'),
    PatternValidator(r'[a-zA-Z]+', errorText: 'Name cannot have digits')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Enter an email'),
    EmailValidator(errorText: 'Enter a valid email'),
  ]);

  final dateValidator = MultiValidator([
    RequiredValidator(errorText: 'Enter a date'),
  ]);

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading() //mets le loader en full page sinon creer la vue
        : Scaffold(
            // backgroundColor: Color.fromRGBO(41, 42, 75, 1),
            // appBar: AppBar(
            //   backgroundColor: Color.fromRGBO(25, 26, 46, 1),
            //   elevation: 0.0,
            //   title: Text(
            //       showSignIn // ? = si showSignIn est true : = sinon fait ca
            //           ? 'Sign in to novalinguo'
            //           : 'Register to novalnguo'),
            //   actions: <Widget>[
            //     TextButton.icon(
            //       icon: Icon(
            //         Icons.person,
            //         color: Colors.white,
            //       ),
            //       label: Text(showSignIn ? "Register" : 'Sign In',
            //           style: TextStyle(color: Colors.white)),
            //       onPressed: () => toggleView(),
            //     ),
            //   ],
            // ),

            // LE BODY #############################################################
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(children: [
                      Container(
                        //padding: EdgeInsets.all(20),
                        alignment: Alignment.topLeft,
                        height: 100,
                        child: IconButton(
                          icon: Icon(Icons.west),
                          iconSize: 50.0,
                          color: Color.fromRGBO(131, 133, 238, 1),
                          onPressed: () => toggleView(),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 100,
                        child: Image.asset(
                          'assets/icon/logo.png',
                        ),
                      ),
                    ]),
                    Container(
                      alignment: Alignment.topLeft,
                      //padding: EdgeInsets.all(20),
                      //height: 150,
                      child: Text(
                        /*
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        */
                        showSignIn ? 'Sign in' : 'Sign up',
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
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Name'),
                              validator: nameValidator,
                            ),
                          )
                        : Container(),
                    !showSignIn ? SizedBox(height: 10.0) : Container(),
                    SizedBox(height: 20.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: TextFormField(
                        controller: emailController,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: emailValidator,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: TextFormField(
                        controller: passwordController,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: !showSignIn
                            ? passwordValidatorSignUp
                            : passwordValidatorSignIn,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    !showSignIn
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: ageController,
                              decoration: InputDecoration(
                                labelText: 'Date of birth',
                                icon: Icon(Icons.calendar_today),
                              ),
                              validator: dateValidator,
                              onTap: () {
                                // setState(() {
                                FocusScope.of(context).requestFocus(
                                    new FocusNode()); // permet de ne pas afficher le clavier
                                _selectDate(context);
                                // });
                              },
                            ),
                          )
                        : Container(),
                    !showSignIn ? SizedBox(height: 10.0) : Container(),
                    //SizedBox(height: 30.0),
                    !showSignIn
                        ? Row(children: <Widget>[
                            Checkbox(
                              value: isChecked,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isChecked = newValue!;
                                });
                              },
                              activeColor: Colors.indigo,
                            ),
                            // Expanded() permet de pas dépasser l'espace du telephone
                            Expanded(
                              child: Text(
                                'I accept general conditions',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'Raleway'),
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
                            'Next',
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
                            if (_formKey.currentState?.validate() == true) {
                              setState(() => loading = true);
                              var password = passwordController.value.text;
                              var email = emailController.value.text;
                              var name = nameController.value.text;
                              var age =
                                  DateTime.parse(ageController.value.text);
                              print(age);
                              var country = "";
                              var description = "";
                              var image = "";
                              dynamic result = showSignIn
                                  ? await _auth.signInWithEmailAndPassword(
                                      email, password)
                                  : await _auth.registerWithEmailAndPassword(
                                      name,
                                      email,
                                      password,
                                      age,
                                      country,
                                      description,
                                      image);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Email or password are not correct';
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
                                'Already registered ?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'Raleway'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Log in',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontFamily: 'Raleway'),
                                  ),
                                  TextButton(
                                    child: Text('RIGHT HERE !',
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
                    showSignIn
                        ? Column(children: [
                            TextButton(
                              child: Text(
                                'Forgot password ?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'Raleway'),
                              ),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ResetScreen())),
                            ),
                          ])
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
            /*
            floatingActionButton: FloatingButton(),
            bottomNavigationBar: BottomNavigation(),
            // Je place ensuite le Bouton au millieu
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            // Permet de voir les element de la page entre le bouton Acceuil et footerBar
            extendBody: true,
            */
          );
  }
}
