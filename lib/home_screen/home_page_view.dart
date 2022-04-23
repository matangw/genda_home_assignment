import '../models/user.dart';

abstract class HomePageView{


  //  abstract function to use when all data finished loading
  void finishedLoading();

  // abstract function to use when user changes filter
  void filterChanged(List<User> usersMatched,int filter);

}