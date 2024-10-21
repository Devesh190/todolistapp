import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/feature/home/provider/task_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do App'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return taskProvider.tasks.isEmpty
              ? Center(child: Text('No Task Found'))
              : Padding(
                  padding: EdgeInsets.all(16),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3),
                      itemCount: taskProvider.tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 3,
                          color: taskProvider.tasks[index]['isComplete']
                              ? Colors.green
                              : Colors.white,
                          surfaceTintColor: Colors.white,
                          child: TaskCard(
                            title: taskProvider.tasks[index]['title']!,
                            description: taskProvider.tasks[index]
                                ['description']!,
                            onEdit: () => editTaskDialog(context, index),
                            onDelete: () => taskProvider.deteleTask(index),
                            onToggleComplete: () =>
                                taskProvider.toggleCompleteTask(index),
                            isComplete: taskProvider.tasks[index]['isComplete'],
                          ),
                        );
                      }),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<void> addTaskDialog(BuildContext context) async {
  String title = '';
  String description = '';
  final taskProvider = Provider.of<TaskProvider>(context, listen: false);
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => title = value,
                decoration: InputDecoration(hintText: 'Task Title'),
              ),
              TextField(
                onChanged: (value) => description = value,
                decoration: InputDecoration(hintText: 'Task description'),
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (title.isEmpty || description.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("title and descriotion cannot be empty")));
                    return;
                  }
                  taskProvider.addTask(title, description);
                  Navigator.pop(context);
                },
                child: Text('ADD'))
          ],
        );
      });
}

Future<void> editTaskDialog(BuildContext context, int index) async {
  final taskProvider = Provider.of<TaskProvider>(context, listen: false);
  String title = taskProvider.tasks[index]['title']!;
  String description = taskProvider.tasks[index]['description']!;

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: title),
                onChanged: (value) => title = value,
                decoration: InputDecoration(hintText: 'Task Title'),
              ),
              TextField(
                controller: TextEditingController(text: description),
                onChanged: (value) => description = value,
                decoration: InputDecoration(hintText: 'Task description'),
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (title.isEmpty || description.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("title and descriotion cannot be empty")));
                    return;
                  }
                  taskProvider.editTask(index, title, description);
                  Navigator.pop(context);
                },
                child: Text('ADD'))
          ],
        );
      });
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;
  final bool isComplete;
  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.onEdit,
    required this.onDelete,
    required this.isComplete,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(height: 10),
          Text(description),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: onToggleComplete,
                  child:
                      Text(isComplete ? 'Mark Incomplete' : 'Mark Complete')),
              IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
              IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
