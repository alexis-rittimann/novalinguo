import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:novalinguo/common/bottomBar.dart';
import 'package:novalinguo/common/constants.dart';
import 'package:novalinguo/screens/authenticate/authenticate_screen.dart';
import 'package:novalinguo/services/user.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final UserService userSevice = UserService();
  final _formKey = GlobalKey<FormState>();
  final countryController = TextEditingController();
  final descriptionController = TextEditingController();

  final countryValidator = MultiValidator([
    RequiredValidator(errorText: 'Enter country'),
    PatternValidator(r'[a-zA-Z]+', errorText: 'Name cannot have digits')
  ]);

  @override
  void dispose() {
    countryController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 42, 75, 1),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: TextFormField(
                          controller: countryController,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Country'),
                          validator: countryValidator),
                    ),
                    SizedBox(height: 20.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: TextFormField(
                          controller: descriptionController,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Description'),
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: 6,
                          validator: countryValidator),
                    ),
                  ],
                )),
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
            SizedBox(height: 20.0),
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
                      // var country = countryController.value.text;
                      // var description = descriptionController.value.text;

                    }
                  },
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
