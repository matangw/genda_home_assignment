class Level{
  String name;
  List<String> apartments;

  Level({required this.name,required this.apartments});

  factory Level.fromJson(Map<String,dynamic> json){
    return Level(
      name: json['name'],
      apartments: json['apartments'] ==null ? [] : json['apartments'].cast<String>()
    );
  }



}