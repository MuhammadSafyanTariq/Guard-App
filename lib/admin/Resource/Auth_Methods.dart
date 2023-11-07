import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:guard/admin/Models/Employer.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<EmployerModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return EmployerModel.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser({
    required String companyName,
    required String address,
    required String phone,
    required String email,
    required String correspondingPerson,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (companyName.isNotEmpty ||
          email.isNotEmpty ||
          address.isNotEmpty ||
          phone.isNotEmpty ||
          correspondingPerson.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // String photoUrl = await StorageMehtods()
        //     .uploadImagetoStorage('profilePics', file, false);

        EmployerModel _user = EmployerModel(
          companyName: companyName,
          uid: _auth.currentUser!.uid,
          email: email,
          phone: phone,
          correspondingPerson: correspondingPerson,
          address: address,
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> editProfile({
    required String companyName,
    required String address,
    required String phone,
    required String correspondingPerson,
    required String imageUrl,
  }) async {
    String res = "Some error Occurred";
    try {
      if (companyName.isNotEmpty ||
          address.isNotEmpty ||
          phone.isNotEmpty ||
          correspondingPerson.isNotEmpty ||
          imageUrl.isNotEmpty) {
        // String photoUrl = await StorageMehtods()
        //     .uploadImagetoStorage('profilePics', file, false);

        EmployerModel _user = EmployerModel(
          companyName: companyName,
          uid: _auth.currentUser!.uid,
          email: FirebaseAuth.instance.currentUser!.email.toString(),
          phone: phone,
          correspondingPerson: correspondingPerson,
          address: address,
          photoUrl: imageUrl,
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
