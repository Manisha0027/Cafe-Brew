import 'package:flutter/material.dart';

import 'package:flutter_firebase/model/brew.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase/screen/home/brew_tile.dart';


class Brewlist extends StatefulWidget {
  @override
  _BrewlistState createState() => _BrewlistState();
}

class _BrewlistState extends State<Brewlist> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
    //print(brew.documents);

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
        return BrewTile(brew:brews[index]);
      },
      
    );
  }
}