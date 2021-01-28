import 'package:coffee_shop_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserId _userFromFirebaseUser(User user) {
    return user != null ? UserId(uid: user.uid) : null;
  }

  Stream<UserId> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    //this does exactly the same thing from below comment line
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // ------- register with email and password ---------
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User user = result.user;

      // TODO: create a new firestore document for the user with uid 

      return _userFromFirebaseUser(user); 
      
    } on FirebaseAuthException catch(e) {
      if(e.code == 'weak-password') {
        print('password provided is too weak');
      } else if(e.code == 'email-already-in-use') {
        print('The account alread exists for that email');
      }
    }
  }
  // ------- End register with email and password ---------


  // ----------- Sign In with email and Password ---------------
  Future signInWithEmailAndPassword(String email, String password) async {
    try {

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      User user = result.user;
      return _userFromFirebaseUser(user);

    } on FirebaseAuthException catch(e) {
      if(e.code == 'user-not-found') {
        print('No user found for the email');
        Fluttertoast.showToast(
          msg: 'No user found for the email',
          toastLength: Toast.LENGTH_SHORT,
        );
      } else if(e.code == 'wrong-password') {
        print('Wrong password provided for that user');
        Fluttertoast.showToast(
          msg: 'Wrong password provided for that user',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }
  }
  // ----------- End Sign In with email and Password ---------------

  // -------- Log Out ----------
  Future LogOut() async {
    
    try{
      return _auth.signOut();
    } catch(e) {
      print(e.toString());
    }

  }
  // -------- End Log Out ----------
}