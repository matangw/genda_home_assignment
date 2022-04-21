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

  List<User> getCheckedInWorkers(){
    return model.workers.where((worker) => worker.isCheckedIn == true).toList();
  }

  List<User> getCHeckedOutWorkers(){
    return model.workers.where((worker) => worker.isCheckedIn ==false).toList();
  }

  List<User> workersInLevel(Level level){
    return model.workers.where((worker)=> worker.location.level == int.tryParse(level.name)).toList();

  }
  List<User> workersForContractor(Contractor contractor,{List<User>? workersWithStatus}){
    List<User> list = workersWithStatus?? model.workers;
    return list.where((worker) => worker.contractorId == contractor.number).toList();
  }

  Contractor contractorById(int id){
    return model.contractors.firstWhere((element) => element.number == id);
  }

  ///presentation variable manipulation
  Map<int,int> numberOfPeopleInLevelMap(){
    Map<int,int> result = Map();
    for(var level in model.levels){
      int numberOfWorkers = workersInLevel(level).where((worker) =>worker.isCheckedIn).toList().length;
      result.putIfAbsent(int.tryParse(level.name) as int, () => numberOfWorkers);
    }
    return result;
  }

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

  List<User> checkedInWorkersForContractor(Contractor contractor){
    return model.workers.where((element) => element.contractorId == contractor.number&&element.isCheckedIn).toList();
  }

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

  String locationString(Location location){
    return 'Level #${location.level} | Apt #${location.apartment}';
  }

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
  int getNumberOfWorkersInLevel(int levelName){
    return numberOfPeopleInLevelMap()[levelName] as int;
  }

  /// ui setState changes
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