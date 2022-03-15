import 'package:hive/hive.dart';
part 'TaskModel.g.dart';

@HiveType(typeId: 1)
class ModelTask{
  @HiveField(0)
  String title;
  
  @HiveField(1,defaultValue: false)
  bool checked;

  ModelTask({required this.title, required this.checked});

}