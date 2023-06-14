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
    on<MarkFavouriteOrUnFavouriteTask>(_onMarkFavouriteOrUnFavourite);
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
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true))
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false))
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

  void _onMarkFavouriteOrUnFavourite(
    MarkFavouriteOrUnFavouriteTask event,
    Emitter<TasksState> emit,
  ) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.pendingTasks;
    List<Task> favouriteTasks = state.pendingTasks;
    if(!event.task.isDone!){
      if(!event.task.isFavourite){
        var index = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
        ..remove(event.task)
        ..insert(index, event.task.copyWith(isFavourite: true));
        favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      }else{
        var index = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
        ..remove(event.task)
        ..insert(index, event.task.copyWith(isFavourite: false));
        favouriteTasks.remove(event.task);
      }
    }else{
      if(!event.task.isFavourite){
        var index = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
        ..remove(event.task)
        ..insert(index, event.task.copyWith(isFavourite: true));
        favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      }else{
        var index = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
        ..remove(event.task)
        ..insert(index, event.task.copyWith(isFavourite: false));
        favouriteTasks.remove(event.task);
      }
    }
    emit(TasksState(
        favouritesTasks: favouriteTasks,
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      removedTasks: state.removedTasks
    ));
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
