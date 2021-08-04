import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'HttpException.dart';

class Task {
  final String id;
  final String mytask;
  final String shortRef;
  final DateTime date;

  Task(
      {@required this.id,
      @required this.mytask,
      @required this.date,
      @required this.shortRef});
}

class Tasks with ChangeNotifier {
  List<Task> _tasks = [
    // Task(
    //     id: DateTime.now().toString(),
    //     date: DateTime.now(),
    //     mytask: 'Create this app',
    //     shortRef: 'Finish Asap'),
    // Task(
    //     id: DateTime.now().toString(),
    //     date: DateTime.now(),
    //     mytask: 'Create this app',
    //     shortRef: 'Finish Asap'),
    // Task(
    //     id: DateTime.now().toString(),
    //     date: DateTime.now(),
    //     mytask: 'Create this app',
    //     shortRef: 'Finish Asap'),
    // Task(
    //     id: DateTime.now().toString(),
    //     mytask: 'Finish the first app',
    //     date: DateTime.now(),
    //     shortRef: 'That also has to be submittd'),
    // Task(
    //     id: DateTime.now().toString(),
    //     mytask: 'Finish the first app',
    //     date: DateTime.now(),
    //     shortRef: 'That also has to be submittd'),
    // Task(
    //     id: DateTime.now().toString(),
    //     mytask: 'Finish the first app',
    //     date: DateTime.now(),
    //     shortRef: 'That also has to be submittd'),
  ];

  List<Task> _completedTasks = [];

  List<Task> get myTasksList {
    return [..._tasks];
  }

  List<Task> get completedTasks {
    return [..._completedTasks];
  }

  Future<void> fetchAndSetTasks() async {
    final url = Uri.parse(
        'https://todo-list-30b36-default-rtdb.asia-southeast1.firebasedatabase.app/tasks.json');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<Task> loadedTasks = [];
    if (extractedData == null) {
      print('i am returning');
      return;
    }
    extractedData.forEach((taskId, taskObj) {
      loadedTasks.add(Task(
          id: taskId,
          mytask: taskObj['mytask'],
          date: DateTime.parse(taskObj['date']),
          shortRef: taskObj['shortRef']));
    });
    _tasks = loadedTasks;
    notifyListeners();
  }

  Future<void> fetchAndSetCompletedTask() async {
    final url = Uri.parse(
        'https://todo-list-30b36-default-rtdb.asia-southeast1.firebasedatabase.app/CompletedTask.json');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<Task> loadedCompletedTasks = [];
    if (extractedData == null) {
      print('i am returning');
      return;
    }
    extractedData.forEach((taskId, taskObj) {
      loadedCompletedTasks.add(Task(
          id: taskId,
          mytask: taskObj['mytask'],
          date: DateTime.parse(taskObj['date']),
          shortRef: taskObj['shortRef']));
    });
    _completedTasks = loadedCompletedTasks;
    notifyListeners();
  }

  Future<void> addToCompletedTask(String taskid) async {
    final url = Uri.parse(
        'https://todo-list-30b36-default-rtdb.asia-southeast1.firebasedatabase.app/tasks/$taskid.json');
    int index = _tasks.indexWhere((element) => element.id == taskid);
    final elementRemovedFromTask = _tasks[index];
    _tasks.removeAt(index);
    notifyListeners();
    await http.delete(url); //still have to add error handling here
    addingFromUrL(elementRemovedFromTask);
  }

  Future<void> addingFromUrL(final elementCompleted) async {
    final url = Uri.parse(
        'https://todo-list-30b36-default-rtdb.asia-southeast1.firebasedatabase.app/CompletedTask.json');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'mytask': elementCompleted.mytask,
          'shortRef': elementCompleted.shortRef,
          'date': timestamp.toIso8601String(),
        }));

    Task completedtask = new Task(
        date: elementCompleted.date,
        id: json.decode(response.body)['name'],
        mytask: elementCompleted.mytask,
        shortRef: elementCompleted.shortRef);
    _completedTasks.add(completedtask);
    notifyListeners();
  }

  Future<void> addtoTask(Task task) async {
    final url = Uri.parse(
        'https://todo-list-30b36-default-rtdb.asia-southeast1.firebasedatabase.app/tasks.json');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'mytask': task.mytask,
          'shortRef': task.shortRef,
          'date': timestamp.toIso8601String()
        }));
    task = new Task(
        id: json.decode(response.body)['name'],
        mytask: task.mytask,
        date: task.date,
        shortRef: task.shortRef);
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> removeTask(String tskid) async {
    final url = Uri.parse(
        'https://todo-list-30b36-default-rtdb.asia-southeast1.firebasedatabase.app/tasks/$tskid.json');
    final _index = _tasks.indexWhere((element) => element.id == tskid);
    var removedElement = _tasks[_index];
    _tasks.removeAt(_index);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _tasks.insert(_index, removedElement);
      notifyListeners();
      throw HttpException('could not delete');
    }
    removedElement = null;
  }
}
