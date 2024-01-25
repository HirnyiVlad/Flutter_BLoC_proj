part of 'task_bloc.dart';

// Abstract class representing events related to tasks in the application
@immutable
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  // Equatable method to ensure correct comparison of event objects
  @override
  List<Object> get props => [];
}

// Event class for loading the task counter
class LoadTaskCounter extends TaskEvent {}

// Event class for adding a task, includes the task to be added
class AddTask extends TaskEvent {
  final TaskModel task;

  // Constructor for AddTask event, requiring the task to be added
  const AddTask({required this.task});

  // Override to include the task in the list of props for equality comparison
  @override
  List<Object> get props => [task];
}

// Event class for removing a task, includes the task to be removed
class RemoveTask extends TaskEvent {
  final TaskModel task;

  // Constructor for RemoveTask event, requiring the task to be removed
  const RemoveTask({required this.task});

  // Override to include the task in the list of props for equality comparison
  @override
  List<Object> get props => [task];
}

// Event class for editing a task, includes the edited task
class EditTask extends TaskEvent {
  final TaskModel editedTask;

  // Constructor for EditTask event, requiring the edited task
  const EditTask({required this.editedTask});

  // Override to include the edited task in the list of props for equality comparison
  @override
  List<Object> get props => [editedTask];
}

// Event class for filtering tasks by completeness, includes the filtered tasks
class FilterByCompleteness extends TaskEvent {
  final List<TaskModel>  filteredTask;

  // Constructor for FilterByCompleteness event, requiring the filtered tasks
  const FilterByCompleteness({required this.filteredTask});

  // Override to include the filtered tasks in the list of props for equality comparison
  @override
  List<Object> get props => [filteredTask];
}

// Event class for filtering tasks by category, includes the filtered tasks
class FilterByCategory extends TaskEvent {
  final List<TaskModel>  filteredTask;

  // Constructor for FilterByCategory event, requiring the filtered tasks
  const FilterByCategory({required this.filteredTask});

  // Override to include the filtered tasks in the list of props for equality comparison
  @override
  List<Object> get props => [filteredTask];
}
