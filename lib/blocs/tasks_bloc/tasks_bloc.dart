import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
export 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../models/task_model.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emmit) {
    final state = this.state;
    emmit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: List.from(
        state.completedTasks,
      ),
      favouritesTasks: List.from(
        state.favouritesTasks,
      ),
      removedTasks: List.from(
        state.removedTasks,
      ),
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emmit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    !task.isDone!
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)..insert(0, task.copyWith(isDone: true))
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)..insert(0, task.copyWith(isDone: false))
          };
    emmit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favouritesTasks: state.favouritesTasks,
        removedTasks: state.removedTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emmit) {
    final state = this.state;
    emmit(TasksState(
        pendingTasks: state.pendingTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task)));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emmit) {
    final state = this.state;
    emmit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favouritesTasks: List.from(state.favouritesTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: true))));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
