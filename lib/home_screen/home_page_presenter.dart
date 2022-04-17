import 'package:genda_home_assignment/home_screen/home_page_model.dart';
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

  /// helping hand functions
  int getNumberOfWorkersInLevel(int levelName){
    return numberOfPeopleInLevelMap()[levelName] as int;
  }






}