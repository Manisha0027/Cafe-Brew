import 'package:flutter/material.dart';
import 'package:flutter_firebase/screen/home/brew_list.dart';
import 'package:flutter_firebase/screen/home/setting_form.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';

import 'package:flutter_firebase/model/brew.dart';


class Home extends StatelessWidget {
final AuthService  _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel(){
      showModalBottomSheet(context:context,builder:(context){
        return Container(
      
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
            child: SettingsForm(),
        
        );
      });
    }
    MediaQuery.of(context).size.width;
      MediaQuery.of(context).size.height;
    return StreamProvider<List<Brew>>.value(
        value: DatabaseService().brews,
          child: Scaffold(
      
        appBar: AppBar(
          title:Text("Home",
          style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.yellow[700],
          elevation: 0.0,
          actions: <Widget>[
        
         FlatButton.icon(
                color: Colors.yellow[700],
                icon: Icon(Icons.person),
                label: Text("logout"),
                
              
                onPressed: () async{
                  await _auth.signOut();
                },
              ),
            
            FlatButton.icon(
              icon: Icon(Icons.settings),
             label: Text(""),
              onPressed: ()=>_showSettingPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/index.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Brewlist()),
      ),
    );
  }
}