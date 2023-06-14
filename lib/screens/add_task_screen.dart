import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_app_with_bloc/models/task_model.dart';
import 'package:task_app_with_bloc/services/guide_gen.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Title",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          autofocus: true,
          controller: titleController,
          decoration: const InputDecoration(
            label: Text("Title"),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          autofocus: true,
          minLines: 3,
          maxLines: 5,
          controller: descriptionController,
          decoration: const InputDecoration(
            label: Text("Description"),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: ()=>Navigator.pop(context),
                child: const Text("cancel")
            ),

            TextButton(
                onPressed: (){
                  var task = Task(
                      id: GUIDGen.generate(),
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateFormat("dd MMMM yyyy").format(DateTime.now())
                  );
                  context.read<TasksBloc>().add(AddTask(task: task));
                  titleController.text = "";
                  Navigator.pop(context);
                },
                child: const Text("add"))
          ],
        )
      ],
    );
  }
}
