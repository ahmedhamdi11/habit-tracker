import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/month_summary.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/components/my_alert_box.dart';
import 'package:habit_tracker/data/habit_database.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HabitDatabase db =HabitDatabase();

  @override
  void initState() {
    //check if there is no current habit list to create default data
    //if there is a current habit list load it
    if(db.myBox.get('CURRENT_HABIT_LIST')==null){
      db.createDefaultData();
    }else{
      db.loadData();
    }
    //update database
    db.updateData();
    super.initState();
  }
  //check box was tapped
  void checkBoxTapped(bool? value,int index){
    setState(() {
      db.todayHabitList[index][1]=value!;
    });
    db.updateData();
  }

  //Save new habit
  saveNewHabit(){
    setState(() {
      db.todayHabitList.add([newHabitController.text,false]);
    });
    newHabitController.clear();
    Navigator.pop(context);
    db.updateData();
  }

  //cancel new habit
  cancelNewHabit(){
    newHabitController.clear();
    Navigator.pop(context);
  }

  //Create new habit
  var newHabitController= TextEditingController();
  void createNewHabit(){
    //show alert dialog for user to enter new habit
    showDialog(
        context: context,
        builder: (context)=>MyAlertBox(
          controller:newHabitController,
          onSave: saveNewHabit,
          onCancel: cancelNewHabit,
          hintText: 'Enter habit name..',
        )
    );
  }

  //delete habit
  void deleteHabit(int index){
    setState(() {
      db.todayHabitList.removeAt(index);
    });
    db.updateData();
  }

  //open habit setting to edit
  openHabitSetting(int index){
    showDialog(
        context: context,
        builder: (context)=>MyAlertBox(
            controller: newHabitController,
            onSave: ()=>saveExistingHabit(index),
            onCancel: cancelNewHabit,
          hintText: db.todayHabitList[index][0],
        )
    );
  }

  //save existing habit with a new name
  void saveExistingHabit(int index){
    setState(() {
      db.todayHabitList[index][0]=newHabitController.text;
    });
    newHabitController.clear();
    Navigator.pop(context);
  }


  @ override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFab(
        onPressed: createNewHabit,
      ),
      body: ListView(
        children: [
          MonthSummary(dataSets: db.heatMapDataSet, startDate: db.myBox.get('START_DATE')),
          ListView.builder(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todayHabitList.length,
              itemBuilder: (context,index){
                return HabitTile(
                   habitName:db.todayHabitList[index][0],
                   habitCompleted:db.todayHabitList[index][1],
                   onChanged:(value)=>checkBoxTapped(value,index),
                   deleteTapped:(context)=>deleteHabit(index) ,
                   settingTapped: (context)=>openHabitSetting(index),
                );
              }
          ),
        ],
      ),
    );
  }
}