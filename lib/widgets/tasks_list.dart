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
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: tasksList.length,
        itemBuilder: (context, position) {
          return TaskTile(task: tasksList[position]);
        },
      ),
    );
  }
}
