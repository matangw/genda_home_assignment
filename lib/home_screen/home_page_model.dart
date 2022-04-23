import 'package:flutter/services.dart';
import 'package:genda_home_assignment/home_screen/home_page_view.dart';
import 'package:genda_home_assignment/models/contractor.dart';
import 'package:genda_home_assignment/models/level.dart';
import 'package:genda_home_assignment/models/location.dart';
import 'package:genda_home_assignment/models/user.dart';
import 'dart:convert';

class HomePageModel{

  HomePageView view ;


  ///controlled data
  //all the workers
  late List<User> workers = [];
  //all the levels
  late List<Level> levels = [];
  // all the contractors
  late List<Contractor> contractors = [];


  //instantiate and than gather all the data
  HomePageModel(this.view){
    getAllData();
  }

  // get all the data in order
  Future<void> getAllData()async{
    await getDataFromJsonFile();
    view.finishedLoading();

  }

  // translate all the data into its parameters form  the json file
  Future<void> getDataFromJsonFile() async{
    final String response = await rootBundle.loadString('data/response.json'); ///file name
    final data = await json.decode(response);

    getLevelsData(data['levels']);
    getContractorData(data['contractors']);
    getWorkersData(data['users']);

    print('workers data :: '+workers.length.toString());
    print('first level number and apartments: '+ levels[0].name +' '+ levels[0].apartments.toString());
    print('first contractor name and number: '+contractors[0].name +' '+ contractors[0].number.toString());
  }

  //get workers data from json file with list of users
  void getWorkersData(var json){
    json.forEach((worker){
      workers.add(User.fromJson(worker,levels,));
    });
  }

  //get levels data from json file with list of levels
  void getLevelsData(var json){
    int counter = 0;
    json.forEach((level){
      levels.add(Level.fromJson(level,counter));
      counter++;
    });
  }

  // get contractors data from json file with list of levels
  void getContractorData(var json){
   json.forEach((key, value) {contractors.add(Contractor.fromJson({key:value.values.first})); });
  }


}