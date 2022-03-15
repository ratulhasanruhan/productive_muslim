import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../model/TaskModel.dart';

class TaskController extends ChangeNotifier{

  final taskBox = Hive.box('task');

  addTask(String value, bool check){
    taskBox.add(
        ModelTask(title: value, checked: check, )
    );
    notifyListeners();
  }

  delete(int index){
    taskBox.deleteAt(index);
    notifyListeners();
  }

  deleteAll(){
    taskBox.clear();
    notifyListeners();
  }


}