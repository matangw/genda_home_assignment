import 'package:flutter/services.dart';
import 'package:genda_home_assignment/models/contractor.dart';
import 'package:genda_home_assignment/models/level.dart';
import 'package:genda_home_assignment/models/location.dart';
import 'package:genda_home_assignment/models/user.dart';
import 'dart:convert';

class HomePageModel{

  late List<User> workers = [];
  late List<Level> levels = [];
  late List<Contractor> contractors = [];

  HomePageModel(){
    getDataFromJsonFile();
  }


  Future<void> getDataFromJsonFile() async{
    final String response = await rootBundle.loadString('data/response.json'); ///file name
    final data = await json.decode(response);

    getWorkersData(data['users']);
    getLevelsData(data['levels']);
    getContractorData(data['contractors']);

    print('workers data :: '+workers.length.toString());
    print('first level number and apartments: '+ levels[0].name +' '+ levels[0].apartments.toString());
    print('first contractor name and number: '+contractors[0].name +' '+ contractors[0].number.toString());
  }

  void getWorkersData(var json){
    json.forEach((worker){
      workers.add(User.fromJson(worker));
    });
  }
  void getLevelsData(var json){
    json.forEach((level){
      levels.add(Level.fromJson(level));
    });
  }
  void getContractorData(var json){
   json.forEach((key, value) {contractors.add(Contractor.fromJson({key:value.values.first})); });
  }


}