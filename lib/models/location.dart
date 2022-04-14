class Location{
  int level;
  int apartment;

  Location({required this.level, required this.apartment});


  factory Location.fromJson(Map<String,dynamic> json){
    return Location(
        level: json['level'],
        apartment: json['apartment']
    );
  }

}