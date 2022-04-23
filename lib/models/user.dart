import 'package:genda_home_assignment/models/location.dart';
import 'dart:convert';

import 'level.dart';

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

  // instantiate user using json map
  factory User.fromJson(Map<String,dynamic> json,List<Level> levels){
    return User(
        name: json['name'],
        trade: json['trade'],
        contractorId: int.tryParse(json['contractor']) as int,
        isCheckedIn: json['isCheckedIn'],
        location: Location.fromJson(json['location'],levels),
        lastSeen: json['lastSeen']
    );
  }
}