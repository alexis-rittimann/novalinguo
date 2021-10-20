import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:novalinguo/models/user.dart';

class DatabaseService {
  final currentUser = FirebaseAuth.instance.currentUser;

  final String uid;

  DatabaseService(this.uid);

  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> saveUser(String name, String age, String? country,
      String? description, String? image, bool isConnected) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'age': age,
      'description': description,
      'country': country,
      'image': image,
      'isConnected': isConnected
    });
  }

  Future<void> connectToChat() async {
    return await userCollection.doc(uid).update({'isConnected': true});
  }

  Future<void> profilUpdate(
      String? country, String? description, String? image) async {
    return await userCollection.doc(uid).update({
      'description': description,
      'country': country,
      'image': image,
    });
  }

  AppUserData _userFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return AppUserData(
        uid: snapshot.id,
        name: data['name'],
        age: data['age'],
        country: data['country'],
        description: data['description'],
        image: data['image'],
        isConnected: data['isConnected']);
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserData> _userListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
