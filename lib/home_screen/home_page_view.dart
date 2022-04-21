import '../models/user.dart';

abstract class HomePageView{

  void finishedLoading();
  void filterChanged(List<User> usersMatched,int filter);

}