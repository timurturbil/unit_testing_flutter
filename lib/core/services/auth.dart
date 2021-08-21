import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> currentUser() async {
    final User user = _firebaseAuth.currentUser;
    /* print("this is user ${user}sad"); */
    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    return "Success";
  }
}
