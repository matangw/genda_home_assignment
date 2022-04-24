import 'package:flutter/material.dart';
import 'package:genda_home_assignment/home_screen/home_page_model.dart';
import 'package:genda_home_assignment/models/contractor.dart';
import 'package:genda_home_assignment/models/location.dart';
import 'package:genda_home_assignment/models/user.dart';

import '../models/level.dart';
import 'home_page_view.dart';

class HomePagePresenter{

  HomePageView view;
  late HomePageModel model;

  HomePagePresenter(this.view){
    model = HomePageModel(view);
  }

  /// workers list manipulation
  List<User> getTotalWorkers(){
    return model.workers;
  }

  // return the present workers
  List<User> getCheckedInWorkers(){
    return model.workers.where((worker) => worker.isCheckedIn == true).toList();
  }

  // return the not present workers
  List<User> getCHeckedOutWorkers(){
    return model.workers.where((worker) => worker.isCheckedIn ==false).toList();
  }

  // input: level  , returns all the workers in the input level
  List<User> workersInLevel(Level level){
    return model.workers.where((worker)=> worker.location.levelIndex == level.index).toList();

  }

  //input: contractor name, optinal: workers list with certin status. return all the workers that work for the contractor and have wanted status(optinal)
  List<User> workersForContractor(Contractor contractor,{List<User>? workersWithStatus}){
    List<User> list = workersWithStatus?? model.workers;
    return list.where((worker) => worker.contractorId == contractor.number).toList();
  }

  //input:  contractor id , returns the contractor that answer that id
  Contractor contractorById(int id){
    return model.contractors.firstWhere((element) => element.number == id);
  }

  ///presentation variable manipulation

  // map of all the levels and the number of people currently in them
  Map<int,int> numberOfPeopleInLevelMap(){
    Map<int,int> result = Map();
    for(var level in model.levels){
      int numberOfWorkers = workersInLevel(level).where((worker) =>worker.isCheckedIn).toList().length;
      result.putIfAbsent(int.tryParse(level.name) as int, () => numberOfWorkers);
    }
    return result;
  }

  // returns the 3 most busiest levels in order
  List<Level> topThreeWorkingLevels(){
        List<int> sortedLevelsNames = numberOfPeopleInLevelMap().keys.toList();
        sortedLevelsNames.sort((a, b) =>
        getNumberOfWorkersInLevel(b)?.compareTo(getNumberOfWorkersInLevel(a)) as int);
            if(sortedLevelsNames.length<3){
              List<Level> levelsSorted = [];
              sortedLevelsNames.forEach((level) {
                levelsSorted.add(model.levels.firstWhere((l) => int.tryParse(l.name)== level));
              });
              return levelsSorted;
    }
    List<Level> levelsSorted = [];
    sortedLevelsNames.forEach((level) {
      levelsSorted.add(model.levels.firstWhere((l) => int.tryParse(l.name)== level));
    });
    return levelsSorted.getRange(0, 3).toList();
  }

  // input contractor , returns the list of workers that currently checked in and working for the contractor
  List<User> checkedInWorkersForContractor(Contractor contractor){
    return getCheckedInWorkers().where((element) => element.contractorId == contractor.number).toList();
  }

  // input: last seen var in minuets , returns the string to show in the screen itself
  String lastSeenString(int lastSeen){
    if(lastSeen<60){
      return '${lastSeen} minuets ago';
    }
    else if(lastSeen<1440){
      return '${lastSeen~/60} hours ago';
    }
    else{
    return '${lastSeen~/1440} days ago';
    }

  }

  // input: location vat of user ,  returns the string to show in the screen itself
  String locationString(Location location){
    return 'Level #${model.levels[location.levelIndex].name} | Apt #${model.levels[location.levelIndex].apartments[location.apartmentIndex]}';
  }

  //input trade of user , returns the color that represent the trade
  Color tradeColor(String trade){
    if(trade == 'bricks' ){return Colors.red; }
    else if(trade == 'ceiling'){return Colors.blue;}
    else if(trade == 'doors'){return Colors.green;}
    else if(trade == 'plaster'){return Colors.yellow;}
    else{
      print('no color found for trade $trade');
      return Colors.black;
    }

  }

  /// helping hand functions
  // get number of workers in single level from map
  int getNumberOfWorkersInLevel(int levelName){
    return numberOfPeopleInLevelMap()[levelName] as int;
  }

  /// ui setState changes
  // set new filter state in the screen itself
  void setNewFilter(int filter){
    if(filter == 1 ){
      view.filterChanged(getTotalWorkers(),filter);
    }
    else if(filter ==2){
      view.filterChanged(getCheckedInWorkers(),filter);
    }
    else if(filter ==3){
      view.filterChanged(getCHeckedOutWorkers(),filter);
    }
  }





}