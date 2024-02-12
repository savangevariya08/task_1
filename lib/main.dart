import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/widgets/rounded_btn.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TO_Do(),
  ));
}

class TO_Do extends StatefulWidget {
  const TO_Do({super.key});

  @override
  State<TO_Do> createState() => _TO_DoState();
}

class _TO_DoState extends State<TO_Do> {
  List<Task> tasks = [];
  TextEditingController add_data = TextEditingController();

  loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedTasks = prefs.getStringList('tasks');
    if (savedTasks != null) {
      setState(() {
        tasks = savedTasks.map((task) => Task(task, false)).toList();
      });
    }
  }

  saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskString = tasks.map((task) => task.title).toList();
    prefs.setStringList('tasks', taskString);
  }

  addTask() {
    String newTaskTitle = add_data.text.trim();
    if (newTaskTitle.isNotEmpty) {
      setState(() {
        tasks.add(Task(newTaskTitle, false));
      });
      saveTasks();
      add_data.clear();
    }
  }

  toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
    saveTasks();
  }

  deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: Column(children: [
        Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(border: Border.all(width: 2)),
            child: TextField(
              decoration: InputDecoration(hintText: "Add Data"),
              controller: add_data,
            )),
        Container(
          height: 50,
          width: 120,
          child: RoundedButton(
            bgcolor: Colors.blue,
            btnName: 'Add Task',
            callback: addTask,
          ),
        ),
        Container(
          height: 500,
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index].title),
                leading: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (value) => toggleTask(index),),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteTask(index),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
class Task {
  String title;
  bool isCompleted;
  Task(this.title,this.isCompleted);
}
