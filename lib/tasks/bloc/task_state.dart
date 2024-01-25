part of 'task_bloc.dart';

// Abstract class representing the state of tasks in the application
@immutable
abstract class TasksState extends Equatable {
  const TasksState();

  // Equatable method to ensure correct comparison of state objects
  List<Object> get props => [];
}

// Initial state class indicating that tasks are not loaded yet
class TasksInitial extends TasksState {}

// State class indicating that tasks are loaded and providing the list of tasks
class TasksLoaded extends TasksState {
  final List<TaskModel> tasks;

  // Constructor for TasksLoaded state, requiring the list of tasks
  const TasksLoaded({
    required this.tasks,
  });

  // Override to include the list of tasks in the list of props for equality comparison
  @override
  List<Object> get props => [tasks];
}
