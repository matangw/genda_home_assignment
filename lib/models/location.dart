import 'level.dart';

class Location{
  int levelIndex;
  int apartment;

  Location({required this.levelIndex, required this.apartment});


  // instantiate location using json map
  factory Location.fromJson(Map<String,dynamic> json,List<Level> levels){
    return Location(
        levelIndex: levels[json['level']].index,
        apartment: json['apartment']
    );
  }

}