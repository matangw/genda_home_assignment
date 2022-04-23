class Level{
  int index;
  String name;
  List<String> apartments;

  Level({required this.name,required this.apartments,required this.index});


  // instantiate level using json map
  factory Level.fromJson(Map<String,dynamic> json,int index){
    return Level(
      index: index,
      name: json['name'],
      apartments: json['apartments'] ==null ? [] : json['apartments'].cast<String>()
    );
  }



}