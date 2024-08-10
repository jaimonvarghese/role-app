import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email, password, and role
  Future<User?> signUp(String email, String password, String role) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Save user role to Firestore
      await _firestore.collection('users').doc(user?.uid).set({
        'email': email,
        'role': role,
      });

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signIn  with email and password
  Future<User?> signIn(String email, String password) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
    User? user = result.user;
    return user;
  } on FirebaseAuthException catch (e) {
    
    switch (e.code) {
      case 'user-not-found':
        throw Exception('No user found for that email.');
      case 'wrong-password':
        throw Exception('Wrong password provided.');
      case 'invalid-email':
        throw Exception('The email address is badly formatted.');
      
      default:
        throw Exception('Sign in failed. Please try again.');
    }
  } catch (e) {
   
    throw Exception('An unexpected error occurred. Please try again.');
  }
}



  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // Check if the current user is an admin
  Future<bool> isAdmin() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      return doc['role'] == 'admin';
    }
    return false;
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}




