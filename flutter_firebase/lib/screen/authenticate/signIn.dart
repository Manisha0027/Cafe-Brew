import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:flutter_firebase/shared/constant.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
   final _formkey = GlobalKey<FormState>();
   bool loading = false;
  String email = "";
  String password = "";
  String error = "";
  
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
      MediaQuery.of(context).size.height;
    return loading? Loading(): Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xff270d40),
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        elevation: 0.0,
        title: Text("Sign In",
        style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
            ),
            label: Text("Register"),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Center(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                key: _formkey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                
                    decoration: textInputDecoration.copyWith(hintText: 'Email') ,
                     validator: (val)=>val.isEmpty?"enter the email":null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                   decoration: textInputDecoration.copyWith(hintText: 'Password') ,
                    obscureText: true,
                    validator: (val)=>val.length<6 ?"enter the password 6+ char long":null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    color: Colors.yellow[700],
                    elevation: 20.0,
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      if(_formkey.currentState.validate()){
                        setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailandPassword(email, password);
                    //dynamic result = await _auth.registerWithEmailandPassword(email, password);
                    if(result == null){
                       setState(() {
                         error="Oops! Could not sign in with  those credentials";
                         loading = false;
                         });
                    }
                }
                    },
                  ),
                   SizedBox(height: 12.0),
              Text(error,
              style: TextStyle(color: Colors.red,fontSize: 14.0),),
                ],
              ),
            )),
      ),
    );
  }
}
