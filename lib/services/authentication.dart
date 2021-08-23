import 'package:firebase_auth/firebase_auth.dart';
import 'package:novalinguo/models/user.dart';
import 'package:novalinguo/services/database.dart';

class AuthenticationService {
  // tous le code de firebase authentification
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User? user) {
    //permet d'appeler user de notre user.dart au lieu de l'user firebase
    return user != null ? AppUser(user.uid) : null;
  }

  //permet d'ecouter si l'utilisateur est connecter ou non
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      //gere les erreure de firebase
      print(exception.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String name, String email, String password, String age) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) {
        throw Exception("No user found");
      } else {
        await DatabaseService(user.uid).saveUser(name, age);

        return _userFromFirebaseUser(user);
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
