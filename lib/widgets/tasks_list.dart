import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app_with_bloc/widgets/task_tile.dart';

import '../models/task_model.dart';

class TasksList extends StatelessWidget {
  List<Task> tasksList;

  TasksList({super.key, required this.tasksList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ExpansionPanelList.radio(
          children: tasksList
              .map(
                (task) => ExpansionPanelRadio(
                    value: task.id,
                    headerBuilder: (context, isOpen) => TaskTile(task: task),
                    body: ListTile(
                      title: SelectableText.rich(
                        TextSpan(children: [
                          const TextSpan(
                              text: "Title\n",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(children: [
                            TextSpan(text: "${task.title}\n"),
                          ]),
                          const TextSpan(children: [
                            TextSpan(
                                text: "\n\nDescription\n",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                          const TextSpan(children: [
                            TextSpan(text: "task.description\n"),
                          ]),
                        ]),
                      ),
                    )),
              )
              .toList(),
        ),
      ),
    );
  }
}

// Expanded(
// child: ListView.builder(
// physics: BouncingScrollPhysics(),
// scrollDirection: Axis.vertical,
// shrinkWrap: true,
// itemCount: tasksList.length,
// itemBuilder: (context, position) {
// return TaskTile(task: tasksList[position]);
// },
// ),
// );
