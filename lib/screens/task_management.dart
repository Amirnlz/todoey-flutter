import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:todoey_flutter/constants.dart';

class TaskManagement extends StatefulWidget {
  final String? whichTask;

  const TaskManagement({Key? key, this.whichTask}) : super(key: key);

  @override
  State<TaskManagement> createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {
  late String taskTitle;
  Priority taskPriority = Priority.medium;

  List<DropdownMenuItem<Priority>> get dropDownMenuItems {
    return Priority.values
        .map((priorities) => DropdownMenuItem(
              child: Text(priorities.toShortString()),
              value: priorities,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.whichTask == null ? 'Add Task' : 'Edit Task',
              style: const TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      autofocus: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        taskTitle = value;
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: kDropDownDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DropdownButton<Priority>(
                      items: dropDownMenuItems,
                      value: taskPriority,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      alignment: Alignment.center,
                      onChanged: (value) {
                        setState(() {
                          taskPriority = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            NeumorphicButton(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12.0),
              style: kNeumorphicButtonStyle,
              child: const Text(
                'Done',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Provider.of<TaskData>(context, listen: false)
                    .addTask(taskTitle, taskPriority);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
