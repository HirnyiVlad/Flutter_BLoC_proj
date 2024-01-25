import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_scutum_task/tasks/model/task_model.dart';


class TaskItem extends StatefulWidget {
  final TaskModel task;
  final Function(bool) onCheckboxChanged;

  const TaskItem({
    super.key,
    required this.task,
    required this.onCheckboxChanged,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title: ${widget.task.title}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text('Description: ${widget.task.description}'),
              const SizedBox(height: 8.0),
              Text('Category: ${widget.task.category}'),
            ],
          ),
          Checkbox(
              value: isCompleted,
              //Set opposite value to checkBox and using method with BL from parameters
              onChanged: (value) {
                setState(() {
                  isCompleted = value!;
                });
                widget.onCheckboxChanged(value!);
              })
        ],
      ),
    );
  }
}
