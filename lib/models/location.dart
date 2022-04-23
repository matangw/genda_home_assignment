import 'level.dart';

class Location{
  int levelIndex;
  int apartmentIndex;

  Location({required this.levelIndex, required this.apartmentIndex});


  // instantiate location using json map
  factory Location.fromJson(Map<String,dynamic> json,List<Level> levels){
    return Location(
        levelIndex: levels[json['level']].index,
        apartmentIndex: json['apartment']
    );
  }

}