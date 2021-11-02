import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:novalinguo/common/bottomBar.dart';
import 'package:novalinguo/common/constants.dart';
import 'package:novalinguo/models/user.dart';
import 'package:novalinguo/screens/authenticate/authenticate_screen.dart';
import 'package:novalinguo/services/database.dart';
import 'package:novalinguo/services/user.dart';
import 'package:provider/provider.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final UserService userSevice = UserService();
  final _formKey = GlobalKey<FormState>();
  final countryController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isLoading = false;
  String profileImage = "";

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      setState(() {
        isLoading = true;
      });
    }
    uploadFile(pickedFile);
  }

  Future uploadFile(PickedFile? file) async {
    String fileName =
        DateTime.now().millisecondsSinceEpoch.toString() + ".jpeg";
    try {
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file!.path});
      TaskSnapshot snapshot =
          await reference.putFile(File(file.path), metadata);
      String imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        profileImage = imageUrl;
        print("hello profileImage" + profileImage);
      });
    } on Exception {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "An error is occured");
    }
  }

  final countryValidator = MultiValidator([
    PatternValidator(r'[a-zA-Z]+', errorText: 'Country cannot have digits')
  ]);

  final descriptionValidator = MultiValidator([
    PatternValidator(r'[a-zA-Z]+', errorText: 'Description cannot have digits'),
    MaxLengthValidator(30, errorText: 'Description is too long')
  ]);

  @override
  void dispose() {
    countryController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser?>(context);
    final DatabaseService databaseService = DatabaseService(currentUser!.uid);
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 42, 75, 1),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 30.0),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 30,
                  ),
                  child: GestureDetector(
                    onTap: getImage,
                    child: CircleAvatar(
                      radius: 71,
                      backgroundColor: Colors.grey,
                      child: Image.network(profileImage),
                      // child: CircleAvatar(
                      //   radius: 68,
                      // ),
                    ),
                  ),
                ),
              ],
            ),
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
                          validator: descriptionValidator),
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
                    'Save',
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
                      var country = countryController.value.text;
                      var description = descriptionController.value.text;
                      var image = profileImage;

                      databaseService.profilUpdate(country, description, image);
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
