import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/model/user.dart';
import 'package:flutter_firebase/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userfromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userfromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userfromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailandPassword(String email, String password) async{
     try{
       AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);
        FirebaseUser user = result.user;
        return _userfromFirebaseUser(user);
     }catch(e){
        print(e.toString());
        return null;

     }
  }

   //register with email and password

  Future registerWithEmailandPassword(String email, String password) async{
     try{
       AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);
        FirebaseUser user = result.user;
      

        //create A new document for the user with uid 
        await DatabaseService(uid: user.uid).updateUserData('0', 'brew member', 100);
        return _userfromFirebaseUser(user);
     }catch(e){
        print(e.toString());
        return null;

     }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
