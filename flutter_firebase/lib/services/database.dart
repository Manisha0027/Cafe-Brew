import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/model/brew.dart';
import 'package:flutter_firebase/model/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection("brew");

    Future updateUserData(String sugar , String name, int strength) async{
      return await brewCollection.document(uid).setData({

        'sugar' : sugar,
        'name':name,
         'strength':strength,
      });
    }

    List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
      return snapshot.documents.map((doc){
        return Brew(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugar: doc.data['sugar'] ?? '0',
        );

      }).toList();
    }

    UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
      return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugar: snapshot.data['sugar'],
        strength: snapshot.data['strength'],
      );
    }

      //get  brew stream
      Stream<List<Brew> > get brews{
        return brewCollection.snapshots()
        .map(_brewListFromSnapshot);

      }

      Stream<UserData> get  userData{
        return brewCollection.document(uid).snapshots()
        .map(_userDataFromSnapShot);
      }

    

}