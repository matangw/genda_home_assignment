import 'package:genda_home_assignment/models/location.dart';
import 'dart:convert';

class User{

  String name;
  String trade;
  int contractorId;
  bool isCheckedIn;
  Location location;
  int lastSeen;

  User({
    required this.name,
    required this.trade,
    required this.contractorId,
    required this.isCheckedIn,
    required this.location,
    required this.lastSeen
});

  factory User.fromJson(Map<String,dynamic> json){
    return User(
        name: json['name'],
        trade: json['trade'],
        contractorId: int.tryParse(json['contractor']) as int,
        isCheckedIn: json['isCheckedIn'],
        location: Location.fromJson(json['location']),
        lastSeen: json['lastSeen']
    );
  }
}