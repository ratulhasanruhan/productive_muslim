import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/colors.dart';
import 'package:productive_muslim/controller/task_controller.dart';
import 'package:productive_muslim/model/TaskModel.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool field = false;
  TextEditingController mcontroller = TextEditingController();
  TextEditingController bcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var task = Provider.of<TaskController>(context).taskBox;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        elevation: 0,
        title: const Text('ToDo',
          style: TextStyle(
            color: darkColor,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: const Text("Are you want to delete all items?"),
                      content: const Text('If you want to delete a single items. Please slide on items'),
                      actions: [
                        TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text('No')
                        ),
                        TextButton(
                            onPressed: (){
                              Provider.of<TaskController>(context, listen: false).deleteAll();
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: const Text('Yes')
                        ),
                      ],
                    );
                  }
                );
              },
              icon: const Icon(Icons.delete_sweep_outlined,color: deepColor,)
          ),
        ],
      ),
      body: ListView(
        children: [
          task.isEmpty
          ? const Text('No task',textAlign: TextAlign.center,)
          : ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: task.length,
              itemBuilder: (context, index){
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction){
                    Provider.of<TaskController>(context,listen: false).delete(index);
                  },
                  child: CheckboxListTile(
                    title: Text(task.getAt(index).title,
                      style: TextStyle(
                        color: task.getAt(index).checked ? deepColor : darkColor,
                        fontWeight: FontWeight.bold,
                        decoration: task.getAt(index).checked ? TextDecoration.lineThrough : TextDecoration.none,
                      ),),
                    value: task.getAt(index).checked,
                    onChanged: (value){
                      setState(() {
                        task.putAt(index, ModelTask(title: task.getAt(index).title, checked: value!));
                      });
                    },
                    //subtitle: Text(task[index].description),
                  ),
                );
              }
          ),

          ListTile(
            title: field
            ? TextField(
              autofocus: true,
              controller: mcontroller,
              onSubmitted: (value){
                if(value != ''){
                  Provider.of<TaskController>(context,listen: false).addTask(value, false);
                  mcontroller.clear();
                  field =false;
                }
                setState(() {});
              },
            )
            : Row(
              children: [
                const Icon(Icons.add, color: deepColor,),
                SizedBox(width: 2.w,),
                const Text('New'),
              ],
            ),

            onTap: (){
              setState(() {
                field = true;
              });
            },
          ),

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
              ),
              builder: (context){
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text('Add your Task',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                            fontSize: 18
                        ),),
                      TextField(
                        controller: bcontroller,
                        autofocus: true,
                        onSubmitted: (value){
                          if(value != ''){
                            Provider.of<TaskController>(context).addTask(value, false);
                            Navigator.pop(context);
                            bcontroller.clear();
                          }
                          else{
                            Fluttertoast.showToast(msg: 'Write Something...');
                          }
                        },
                      ),
                      SizedBox(height: 2.h,),
                      MaterialButton(
                        onPressed: (){
                          if(bcontroller.text != ''){
                            Provider.of<TaskController>(context,listen: false).addTask(bcontroller.text, false);
                            Navigator.pop(context);
                            bcontroller.clear();
                          }else{
                            Fluttertoast.showToast(msg: 'Write Something...');
                          }
                        },
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add,color: Colors.white,),
                            Text('ADD',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        },
        child: const Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
