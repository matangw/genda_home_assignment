
import 'package:flutter/material.dart';
import 'package:genda_home_assignment/home_screen/home_page_model.dart';
import 'package:genda_home_assignment/home_screen/home_page_presenter.dart';
import 'package:genda_home_assignment/models/contractor.dart';
import 'package:genda_home_assignment/models/location.dart';

import '../models/level.dart';
import '../models/user.dart';
import 'home_page_view.dart';


class HomePageComponent extends StatefulWidget{


  @override
  State<HomePageComponent> createState() => _HomePageComponentState();
}

class _HomePageComponentState extends State<HomePageComponent> implements HomePageView {


  /// model
  late HomePagePresenter presenter;

  ///loading parameters
  bool isLoading = true;
  List<Contractor> contractors = [];
  List<Level> levels = [];
  List<User> workers = [];

  ///presentation variables
  List<bool> isOpen = [];

  @override
  void initState() {
    presenter = HomePagePresenter(this);
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
   double height = MediaQuery.of(context).size.height - myAppBar().preferredSize.height- MediaQuery.of(context).padding.top;
   double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      appBar: myAppBar(),
      body:  SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: isLoading? const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),)
          :Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              upperContainer(height*0.4, width),
              bottomContainer(height*0.6, width)
            ],
          ),
        ),
      ),

    );
  }



  PreferredSizeWidget myAppBar(){
   return AppBar(
     backgroundColor: Colors.blueGrey,
     leading: const Icon(Icons.list),
     title: const Text('My Team'),
     actions: const [
      Icon(Icons.add),
       Icon(Icons.layers_outlined),
      Icon(Icons.search)
     ],
   );
  }

  Widget upperContainer(double height,double width){
   return Container(
     height: height,
     width: width,
     color: Colors.blueGrey[900],
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         SizedBox(height: height*0.1,),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             dataContainer(height*0.35, width*0.25, presenter.getTotalWorkers().length.toString(), 'TOTAL', 'WORKERS', Colors.white),
             dataContainer(height*0.35, width*0.25, presenter.getCheckedInWorkers().length.toString(), 'CHEACKED', 'IN', Colors.orange),
             dataContainer(height*0.35, width*0.25, presenter.getCHeckedOutWorkers().length.toString(), 'CHEACKED', 'OUT', Colors.blue),
           ],
         ),
         Expanded(child: SizedBox()),
         levelRow(height*0.4, width*0.6, []),
         Container(
           height: height*0.05,
           width: width,
           color: Colors.blueGrey,
         )
       ],
     ),
   );
  }

  Widget dataContainer(double height,double width,String value,String title,String subtitle,Color color){
   return Container(
     margin: EdgeInsets.symmetric(horizontal: width*0.1),
     padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.05),
     height: height,
     width: width,
     color: Colors.blueGrey,
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
         Text(value.toString(),style: TextStyle(color:color,fontSize: height*0.35,fontWeight: FontWeight.bold ),textAlign: TextAlign.start,),
         Text(title,style: TextStyle(color: color,fontSize: height*0.16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
         Text(subtitle,style: TextStyle(color: color,fontSize: height*0.12,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)
       ],
     ),
   );
  }



  Widget levelRow(double height,double width,List<Level> levels){
    print(presenter.numberOfPeopleInLevelMap().toString());
   return Center(
     child: Container(
       height: height,
       width: width,
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.end,
         children: [
           presenter.topThreeWorkingLevels().length<2? Container()
               :levelContainer(height, width*0.3, 0.6,presenter.topThreeWorkingLevels()[1], Colors.blueGrey),
           presenter.topThreeWorkingLevels().isEmpty? Container()
               :levelContainer(height, width*0.3, 0.8, presenter.topThreeWorkingLevels()[0], Colors.blueGrey[400] as Color),
           presenter.topThreeWorkingLevels().length<3? Container()
               :levelContainer(height, width*0.3, 0.3,presenter.topThreeWorkingLevels()[2], Colors.blueGrey[600] as Color)
         ],
       ),
     ),
   );
  }


  Widget levelContainer(double height,double width,double insideHeight,Level level,Color color){
   return Container(
     height: height,
     width: width,
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
         Container(
           height: height*0.15,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(presenter.numberOfPeopleInLevelMap()[int.tryParse(level.name)].toString(),style: TextStyle(color: Colors.blueGrey),),
               Icon(Icons.group,color: Colors.blueGrey[600],),
             ],
           ),
         ),
         SizedBox(height: height*0.05,),
         Container(
           padding: EdgeInsets.symmetric(horizontal: width*0.08),
           color: color,
           height:  height* insideHeight,
           child: Align(
             alignment: Alignment.bottomLeft,
             child: RichText(text: TextSpan(text: 'LVL',style: TextStyle(color: Colors.grey[200],fontSize: height*0.1,fontWeight: FontWeight.bold),children: [
               TextSpan(text: level.name,style: TextStyle(color: Colors.grey[200],fontSize: height*0.2,fontWeight: FontWeight.bold))
             ]),),
           ),
         )
       ],
     ),
   );
  }

  Widget bottomContainer(double height,double width){
   return Container(
     height: height,
     width: width,
     color: Colors.grey[300],
     child:Column(
       children: [
         SizedBox(height: height*0.05,),
         SingleChildScrollView(
           child: ExpansionPanelList(
             elevation: 0,
             dividerColor: Colors.transparent,
             expansionCallback: ((i,newIsOpen)=>setState(()=> isOpen[i]=!newIsOpen)),
             animationDuration: Duration(milliseconds: 300),
             children: contractorPanelListCreation(height*0.2, width),
           ),
         ),
       ],
     )
   );
  }

  List<ExpansionPanel> contractorPanelListCreation(double panelHeight,double panelWidth){
   List<ExpansionPanel> result  = [];
   int counter = 0;
   contractors.forEach((contractor) {
     isOpen.add(false);
     result.add(contractorPanel(panelHeight, panelWidth, contractor, isOpen[counter]));
     counter++;
   });
   return result;
  }


  ExpansionPanel contractorPanel(double height,double width,Contractor contractor,bool thisIsOpen){
    return ExpansionPanel(
      backgroundColor: Colors.transparent,
        headerBuilder: (context, thisIsOpen){
          return Container(
            height: height*0.5,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('contractor name'),
                Expanded(child: SizedBox()),
                Text('1/2 checked in',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                SizedBox(width: width*0.1,)
              ],
            ),
          );
        },
        body: Container(
          color: Colors.transparent,
          height: 300,
          width: width,
          child:ListView(
            padding: EdgeInsets.zero,
            children: workerListCreation(height, width*0.9, [
              User(name:'jj', trade: 'builder',
                  contractorId: 1,
                  isCheckedIn: true, location: Location(level:3 , apartment: 5),
                  lastSeen: 3)]),
          ) ,
        ),
      isExpanded: thisIsOpen
    );

  }


  List<Widget> workerListCreation(double tileHeight,double tileWidth,List<User> workers){
   List<Widget> result = [];
   workers.forEach((worker) {
     result.add(workerListTile(tileHeight, tileWidth, worker));
   });
   return result;
  }

  Widget workerListTile(double height,double width,User user){
      return Center(
        child: Card(
          elevation: 5,
          child: Container(
            color:Colors.white,
            height: height,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.red,
                  width: width*0.03,
                ),
                SizedBox(width: width*0.06,),
                Container(
                  height: height,
                  width: width*0.1,
                  child: Center(
                    child: Icon(Icons.build,color: Colors.grey,),
                  ),
                ),
                SizedBox(width: width*0.06,),
                Container(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('name'),
                      Text('contractor'),
                      Text('last seen'),
                    ],
                  ),
                )

              ],
            )
          ),
        ),
      );
  }

  @override
  void finishedLoading() {
      setState((){
        isLoading = false;
        contractors = presenter.model.contractors;
        levels = presenter.model.levels;
        workers = presenter.model.workers;
      });
 }


}