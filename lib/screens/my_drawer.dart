import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_with_bloc/blocs/switch_bloc/switch_bloc.dart';
import 'package:task_app_with_bloc/screens/recycle_bin.dart';
import 'package:task_app_with_bloc/screens/tabs_screen.dart';
import 'package:task_app_with_bloc/screens/pending_task_screen.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Text("Task Drawer", style: Theme.of(context).textTheme.headline5,),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state){
                return ListTile(
                  onTap: ()=>Navigator.of(context).pushReplacementNamed(TabsScreen.id),
                  leading: const Icon(Icons.folder_special),
                  title: const Text("My tasks"),
                  trailing: Text("${state.pendingTasks.length} | ${state.completedTasks.length}"),
                );
              }
            ),
            BlocBuilder<TasksBloc, TasksState>(builder: (context,state){
              return ListTile(
                onTap: ()=>Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                leading: const Icon(Icons.delete),
                title: const Text("Bin"),
                trailing: Text("${state.removedTasks.length}"),
              );
            }),
            const Divider(),
            BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state){
                  return ListTile(
                    leading: const Icon(Icons.palette),
                    title: const Text("Dark mode"),
                    trailing: Switch(
                      value: state.switchValue,
                      onChanged: (newValue){
                        newValue? context.read<SwitchBloc>().add(SwitchOnEvent(switchValue: newValue))
                        : context.read<SwitchBloc>().add(SwitchOffEvent(switchValue: newValue));
                      },
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}