import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app_with_bloc/screens/recycle_bin.dart';
import 'package:task_app_with_bloc/screens/tabs_screen.dart';
import 'package:task_app_with_bloc/screens/pending_task_screen.dart';

class AppRouter{
  Route onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_)=>TabsScreen());
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_)=> RecycleBin());
      default:
        return MaterialPageRoute(builder: (_)=>TabsScreen());
    }
  }
}