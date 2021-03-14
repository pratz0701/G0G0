import 'package:firebase_auth/firebase_auth.dart';
import 'package:map/models/user.dart';
//import 'package:shubhwed/services/db.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  users _userFromFirebaseUser(User user) {
    return user != null ? users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<users> get user {
    return
      _auth.authStateChanges()
          .map(_userFromFirebaseUser);
  }

//  // sign in anon
//  Future signInAnon() async {
//    try {
//      AuthResult result = await _auth.signInAnonymously();
//      FirebaseUser user = result.user;
//      return _userFromFirebaseUser(user);
//    } catch (e) {
//      print(e.toString());
//      return null;
//    }
//  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // create a new document for the user with the uid
//      await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      print('  hello        ');
      return _userFromFirebaseUser(user);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'email';
      }
    } catch (error) {
      print(error.toString());
      return null;
    }

  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  getUser() async {
    User user = await _auth.currentUser;

    return user.uid;
  }

}