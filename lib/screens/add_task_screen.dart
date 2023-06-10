import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_with_bloc/blocs/bloc/tasks_bloc.dart';
import 'package:task_app_with_bloc/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: ()=>Navigator.pop(context),
                child: const Text("cancel")
            ),

            TextButton(
                onPressed: (){
                  var task = Task(title: titleController.text);
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
