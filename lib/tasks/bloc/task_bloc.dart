import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_scutum_task/tasks/model/task_model.dart';
import 'package:space_scutum_task/tasks/ui/task_item.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TasksState> {
  // Constructor for the TaskBloc, initializes the state to TasksInitial
  TaskBloc() : super(TasksInitial()) {
    // Event handler for loading the task counter
    on<LoadTaskCounter>(
          (event, emit) async {
        // Simulate a delay for loading tasks
        await Future.delayed(const Duration(seconds: 1));
        // Load tasks from SharedPreferences and emit TasksLoaded state
        final tasks = await _loadTasksFromSharedPreferences();
        emit(TasksLoaded(tasks: tasks));
      },
    );

    // Event handler for adding a task
    on<AddTask>(
          (event, emit) async {
        if (state is TasksLoaded) {
          final state = this.state as TasksLoaded;
          // Create a new list with the added task, save to SharedPreferences, and emit updated state
          List<TaskModel> updatedTasks = List.from(state.tasks)
            ..add(event.task);
          _saveTasksToSharedPreferences(updatedTasks);
          emit(TasksLoaded(tasks: updatedTasks));
        }
      },
    );

    // Event handler for removing a task
    on<RemoveTask>(
          (event, emit) {
        if (state is TasksLoaded) {
          final state = this.state as TasksLoaded;
          // Create a new list without the removed task and emit updated state
          emit(TasksLoaded(
            tasks: List.from(state.tasks)..remove(event.task),
          ));
        }
      },
    );

    // Event handler for editing a task
    on<EditTask>(
          (event, emit) {
        if (state is TasksLoaded) {
          final state = this.state as TasksLoaded;
          // Find the index of the edited task in the list
          final int index = state.tasks
              .indexWhere((task) => task.title == event.editedTask.title);
          if (index != -1) {
            // Toggle the isCompleted value of the task
            state.tasks[index] = event.editedTask.copyWith(
              isCompleted: !state.tasks[index].isCompleted,
            );
            // Save the updated tasks to SharedPreferences
            _saveTasksToSharedPreferences(state.tasks);
            // Emit the updated state
            emit(TasksLoaded(tasks: state.tasks));
          }
        }
      },
    );

    // Event handler for filtering tasks by completeness
    on<FilterByCompleteness>((event, emit) async {
      if (state is TasksLoaded) {
        final state = this.state as TasksLoaded;
        // Sort the tasks based on completeness and emit updated state
        List<TaskModel> filteredList = List.from(state.tasks)
          ..sort((a, b) => a.isCompleted ? 0 : 1 - (b.isCompleted ? 0 : 1));
        emit(TasksLoaded(tasks: filteredList));
      }
    });

    // Event handler for filtering tasks by category
    on<FilterByCategory>((event, emit) async {
      if (state is TasksLoaded) {
        final state = this.state as TasksLoaded;
        // Sort the tasks based on category and emit updated state
        List<TaskModel> filteredList = List.from(state.tasks)
          ..sort((a, b) => a.category.compareTo(b.category) );
        emit(TasksLoaded(tasks: filteredList));
      }
    });
  }

  // Helper method to load tasks from SharedPreferences
  Future<List<TaskModel>> _loadTasksFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      // Decode JSON and return a list of TaskModel objects
      final List<dynamic> tasksList = json.decode(tasksJson);
      return tasksList.map((taskJson) => TaskModel.fromJson(taskJson)).toList();
    }
    return [];
  }

  // Helper method to save tasks to SharedPreferences
  Future<void> _saveTasksToSharedPreferences(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    // Encode tasks to JSON and save to SharedPreferences
    final tasksJson = json.encode(tasks.map((task) => task.toJson()).toList());
    prefs.setString('tasks', tasksJson);
  }
}
