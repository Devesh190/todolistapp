

import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> tasks = [];

  void addTask(String title, String description) {
    tasks
        .add({'title': title, 'description': description, 'isComplete': false});
    notifyListeners();
  }

  void editTask(int index, String title, String description) {
    tasks[index] = {'title': title, 'description': description};
    notifyListeners();
  }

  void toggleCompleteTask(int index) {
    tasks[index]['isComplete'] = !tasks[index]['isComplete'];
    notifyListeners();
  }

  void deteleTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }
}
