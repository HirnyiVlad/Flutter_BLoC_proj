import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_scutum_task/tasks/bloc/task_bloc.dart';
import 'package:space_scutum_task/tasks/model/task_model.dart';
import 'package:space_scutum_task/tasks/ui/sort_dialog.dart';
import 'package:space_scutum_task/tasks/ui/task_item.dart';

import '../../data/network_provider/weather_api_impl.dart';
import '../../weather/ui/weather_screen.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  // Controllers for text fields
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();

  // Default category value for the dropdown
  String dropDownValue = 'work';

  // List of available categories for the dropdown
  final List<String> dropDownItems = [
    'work',
    'personal',
    'home',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Screen'),
        centerTitle: true,
        backgroundColor: Colors.grey[600],
        actions: [
          // Button in the app bar to navigate to the WeatherScreen
          IconButton(
            icon: const Icon(Icons.cloud),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WeatherScreen(weatherApi: WeatherApiImpl())),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<TaskBloc, TasksState>(
          builder: (context, state) {
            if (state is TasksInitial) {
              // Loading indicator when tasks are being loaded
              return CircularProgressIndicator(
                color: Colors.lightBlue[300],
              );
            }
            if (state is TasksLoaded) {
              // Main content when tasks are loaded
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Section for adding a new task
                  SizedBox(
                    height: 170,
                    child: Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 85,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TextField(
                                      controller: titleTextController,
                                      decoration: const InputDecoration(
                                        labelText: 'title',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 85,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TextField(
                                      controller: descriptionTextController,
                                      decoration: const InputDecoration(
                                        labelText: 'description',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Dropdown for selecting task category
                              SizedBox(
                                width: 150,
                                child: DropdownButton(
                                  value: dropDownValue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: dropDownItems.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropDownValue = value!;
                                    });
                                  },
                                ),
                              ),
                              // Button to trigger filter dialog
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey[300]),
                                ),
                                onPressed: () {
                                  showAlertDialog(context, () {
                                    // Dispatch FilterByCompleteness event
                                    context.read<TaskBloc>().add(
                                        FilterByCompleteness(
                                            filteredTask: state.tasks));
                                  }, () {
                                    // Dispatch FilterByCategory event
                                    context.read<TaskBloc>().add(
                                        FilterByCategory(
                                            filteredTask: state.tasks));
                                  });
                                },
                                child: Text('Filter'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  // List of tasks
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              color: Colors.white.withOpacity(0.3),
                              child: Dismissible(
                                key: Key(state.tasks[index].title),
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  child: const Icon(Icons.delete),
                                ),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  // Dispatch RemoveTask event
                                  context.read<TaskBloc>().add(
                                      RemoveTask(task: state.tasks[index]));
                                },
                                child: ListTile(
                                  // Display individual task
                                  title: TaskItem(
                                      task: state.tasks[index],
                                      onCheckboxChanged: (value) {
                                        // Dispatch EditTask event
                                        context.read<TaskBloc>().add(
                                              EditTask(
                                                editedTask: state.tasks[index],
                                              ),
                                            );
                                      }),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
      // Button to add a new task
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              // Dispatch AddTask event with the new task
              context.read<TaskBloc>().add(
                    AddTask(
                      task: TaskModel(
                        title: titleTextController.text,
                        description: descriptionTextController.text,
                        category: dropDownValue,
                        isCompleted: false,
                      ),
                    ),
                  );
              // Clear text fields after adding a new task
              titleTextController.clear();
              descriptionTextController.clear();
            },
          )
        ],
      ),
    );
  }
}
