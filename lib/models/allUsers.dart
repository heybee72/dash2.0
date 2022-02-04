import 'package:firebase_database/firebase_database.dart';

class Users{
  String? id;
  String? name;
  String? email;
  String? phone;

  Users({this.id, this.name, this.email, this.phone});

  Users.fromSnapshot(DataSnapshot snapshot){
    id = snapshot.key;
    name = snapshot.value['name'];
    email = snapshot.value['email'];
    phone = snapshot.value['phone'];
  }
}