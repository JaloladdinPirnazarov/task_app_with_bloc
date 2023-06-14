import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/tasks_bloc/tasks_bloc.dart';
import '../widgets/tasks_list.dart';
import 'my_drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = "recycle_bin_screen";
    @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state){
      return Scaffold(
        appBar: AppBar(
          title: const Text("Recycle bin"),
          ),
        drawer: MyDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                  label: Text("${state.removedTasks.length} Tasks")),
            ),
            TasksList(tasksList: state.removedTasks),
          ],
        ),
      );
    });
  }
}
