import 'package:habit_tracker/date_time/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitDatabase {
  var myBox = Hive.box('Habit_Database');
  List todayHabitList =[];
  Map<DateTime,int> heatMapDataSet={};
  //create initial default data
  void createDefaultData() {
    todayHabitList=[
      ['run',false],
      ['read',false],
    ];

    myBox.put('START_DATE', todayDateFormatted());
  }

  //load data if it is already exist
  void loadData() {
    //if its a new day get habit list from database
    if(myBox.get(todayDateFormatted())==null){
      todayHabitList=myBox.get('CURRENT_HABIT_LIST');
      //set all habits completed to false since its a new day
      for(int i=0;i < todayHabitList.length;i++){
        todayHabitList[i][1]=false;
      }
    }else{
      //if its not a new day load the current habit list
      todayHabitList=myBox.get(todayDateFormatted());
    }
  }

//update database
  void updateData() {
    myBox.put(todayDateFormatted(), todayHabitList);
    myBox.put('CURRENT_HABIT_LIST', todayHabitList);
    calculateHabitPercentages();
  }

  //CALCULATE HABIT PERCENTAGE
void calculateHabitPercentages(){
 int habitCompleted=0;
 for(int i=0;i<todayHabitList.length;i++){
   if(todayHabitList[i][1]==true){
     habitCompleted++;
   }
 }
 String percnt =todayHabitList.isEmpty?'0.0':(habitCompleted/todayHabitList.length).toStringAsFixed(1);

 myBox.put('PERCENTAGE_SUMMARY_$todayDateFormatted()', percnt);
}

void loadHeatMap(){
    DateTime startDate=createDateTimeToObject(myBox.get('START_DATE'));
    //count the numbers of days to load
    int daysInBetween =DateTime.now().difference(startDate).inDays;

    for(int i=0;i<daysInBetween;i++){
      String yyyymmdd=convertDateTimeToString(startDate.add(Duration(days: i)));
      double strengthAsPercent =double.parse(myBox.get('PERCENTAGE_SUMMARY_$yyyymmdd')??'0.0');
      //split the date time so we wont worry about hours,mins,secs etc.
      int year=startDate.add(Duration(days: i)).year;
      int month=startDate.add(Duration(days: i)).month;
      int day=startDate.add(Duration(days: i)).day;

      final percentForEachDay=<DateTime,int>{
           DateTime(year,month,day):(10 * strengthAsPercent).toInt(),
      };
      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
}
}
