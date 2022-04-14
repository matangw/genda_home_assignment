import 'dart:convert';
class Contractor{

  int  number;
  String name;

  Contractor({required this.name,required this.number});

  factory Contractor.fromJson(Map<String,dynamic> json){
    return Contractor(
        name: json.values.first,
        number: int.parse(json.keys.first)
    );
  }

  
}