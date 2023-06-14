import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app_with_bloc/screens/completed_tasks_screen.dart';
import 'package:task_app_with_bloc/screens/pending_task_screen.dart';

import 'add_task_screen.dart';
import 'favourite_tasks_screen.dart';
import 'my_drawer.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({super.key});

  static const id = "tabs_screen";

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int pageIndex = 0;

  final List<Map<String, dynamic>> _pageDetails = [
    {"pageName":PendingTasksScreen(), "title" : "Pending Tasks"},
    {"pageName":CompletedTasksScreen(), "title" : "Completed Tasks"},
    {"pageName":FavouriteTasksScreen(), "title" : "Favourite Tasks"}
  ];

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: const AddTaskScreen(),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[pageIndex]["title"]),
      ),
      drawer: MyDrawer(),
      body: _pageDetails[pageIndex]["pageName"],
      floatingActionButton: pageIndex == 0 ? FloatingActionButton(
        onPressed: ()=>_addTask(context),
        tooltip: "Add Task",
        child: const Icon(Icons.add),
      ) : null,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (index){
            setState(() {
              pageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.incomplete_circle),
                label:"Pending Tasks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label:"Completed Tasks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label:"Favourite Tasks",
            ),
          ]
      ),
    );
  }
}
