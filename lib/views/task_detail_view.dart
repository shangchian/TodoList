import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../viewmodels/task_detail_viewmodel.dart';
import 'base_view.dart';

@RoutePage()
class TaskDetailView extends StatelessWidget {
  final Task? task;

  const TaskDetailView({Key? key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final titleNotifier = ValueNotifier<String>(task?.title ?? '');
    final descriptionNotifier = ValueNotifier<String>(task?.description ?? '');
    final dueDateNotifier = ValueNotifier<DateTime?>(task?.dueDate);
    final priorityNotifier = ValueNotifier<String>(task?.priority ?? 'medium');
    final categoryNotifier = ValueNotifier<String>(task?.category ?? 'General');
    final isCompletedNotifier = ValueNotifier<bool>(task?.isCompleted ?? false);

    void _pickDueDate(BuildContext context) async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dueDateNotifier.value ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        dueDateNotifier.value = picked;
      }
    }

    return BaseView(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(task == null ? 'New Task' : 'Edit Task'),
          actions: [
            if (task != null)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  model.deleteTask(task!.id, context);
                },
              ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final newTask = Task(
                    id: task?.id ?? DateTime.now().toString(),
                    title: titleNotifier.value,
                    description: descriptionNotifier.value,
                    dueDate: dueDateNotifier.value ?? DateTime.now(),
                    priority: priorityNotifier.value,
                    category: categoryNotifier.value,
                    isCompleted: isCompletedNotifier.value,
                  );

                  if (task == null) {
                    model.addTask(newTask);
                  } else {
                    model.updateTask(newTask);
                  }

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                ValueListenableBuilder<String>(
                  valueListenable: titleNotifier,
                  builder: (context, title, _) {
                    return TextFormField(
                      initialValue: title,
                      decoration: InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        titleNotifier.value = value!;
                      },
                    );
                  },
                ),
                ValueListenableBuilder<String>(
                  valueListenable: descriptionNotifier,
                  builder: (context, description, _) {
                    return TextFormField(
                      initialValue: description,
                      decoration: InputDecoration(labelText: 'Description'),
                      onSaved: (value) {
                        descriptionNotifier.value = value!;
                      },
                    );
                  },
                ),
                ValueListenableBuilder<DateTime?>(
                  valueListenable: dueDateNotifier,
                  builder: (context, dueDate, _) {
                    return ListTile(
                      title: Text('Due Date: ${dueDate != null ? dueDate.toLocal().toString().split(' ')[0] : 'Not set'}'),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _pickDueDate(context),
                    );
                  },
                ),
                ValueListenableBuilder<String>(
                  valueListenable: priorityNotifier,
                  builder: (context, priority, _) {
                    return DropdownButtonFormField<String>(
                      value: priority,
                      decoration: InputDecoration(labelText: 'Priority'),
                      items: ['low', 'medium', 'high'].map((String priority) {
                        return DropdownMenuItem<String>(
                          value: priority,
                          child: Text(priority),
                        );
                      }).toList(),
                      onChanged: (value) {
                        priorityNotifier.value = value!;
                      },
                      onSaved: (value) {
                        priorityNotifier.value = value!;
                      },
                    );
                  },
                ),
                ValueListenableBuilder<String>(
                  valueListenable: categoryNotifier,
                  builder: (context, category, _) {
                    return TextFormField(
                      initialValue: category,
                      decoration: InputDecoration(labelText: 'Category'),
                      onSaved: (value) {
                        categoryNotifier.value = value!;
                      },
                    );
                  },
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: isCompletedNotifier,
                  builder: (context, isCompleted, _) {
                    return SwitchListTile(
                      title: Text('Completed'),
                      value: isCompleted,
                      onChanged: (value) {
                        isCompletedNotifier.value = value;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }, modelProvider: () => TaskDetailViewModel());
  }
}
