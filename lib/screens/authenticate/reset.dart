import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novalinguo/common/constants.dart';
import 'package:novalinguo/common/loading.dart';
import 'package:novalinguo/screens/authenticate/authenticate_screen.dart';
import 'package:novalinguo/services/authentication.dart';
//import 'package:novalinguo/common/bottomBar.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void setStateForm() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      emailController.text = '';
    });
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Enter a password'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Password must have at least one special character')
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

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading() //Mets le loader en full page sinon créé la vue
        : Scaffold(
            // Body
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(children: [
                      Container(
                        alignment: Alignment.topLeft,
                        height: 100,
                        child: IconButton(
                          icon: Icon(Icons.west),
                          iconSize: 50.0,
                          color: Color.fromRGBO(131, 133, 238, 1),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AuthenticateScreen())),
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
                    SizedBox(height: 35.0),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Please enter email linked to your Novalingo account',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 35.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: TextFormField(
                        controller: emailController,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: emailValidator,
                        onTap: setStateForm,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    // Bouton Send
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
                            'Send',
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
                              var email = emailController.value.text;
                              print(email);
                              dynamic result =
                                  await _auth.sendPasswordResetEmail(email);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                });
                              }
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AuthenticateScreen()));
                            }
                          },
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
