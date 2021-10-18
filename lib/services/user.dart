import 'package:firebase_auth/firebase_auth.dart';
import 'package:novalinguo/models/user.dart';

class UserService {
  // tous le code de firebase authentification
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  AppUser? _userFromFirebaseUser(User? user) {
    //permet d'appeler user de notre user.dart au lieu de l'user firebase
    return user != null ? AppUser(user.uid) : null;
  }

  //permet d'ecouter si l'utilisateur est connecter ou non
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future deleteUser() async {
    try {
      await _auth.currentUser!.delete();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
