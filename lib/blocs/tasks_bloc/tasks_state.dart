part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favouritesTasks;
  final List<Task> removedTasks;

  const TasksState({
    this.pendingTasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.favouritesTasks = const <Task>[],
    this.removedTasks = const <Task>[],
  });

  @override
  List<Object> get props => [
    pendingTasks,
    completedTasks,
    favouritesTasks,
    removedTasks,
  ];

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        pendingTasks: List<Task>.from(map["pendingTasks"]?.map((x) => Task.fromMap(x))),
        completedTasks: List<Task>.from(map["completedTasks"]?.map((x) => Task.fromMap(x))),
        favouritesTasks: List<Task>.from(map["favouritesTasks"]?.map((x) => Task.fromMap(x))),
        removedTasks: List<Task>.from(map["removedTasks"]?.map((x) => Task.fromMap(x))));
  }

  Map<String, dynamic> toMap() {
    return {
      "pendingTasks": pendingTasks.map((x) => x.toMap()).toList(),
      "completedTasks": completedTasks.map((x) => x.toMap()).toList(),
      "favouritesTasks": favouritesTasks.map((x) => x.toMap()).toList(),
      "removedTasks": removedTasks.map((x) => x.toMap()).toList()
    };
  }
}
