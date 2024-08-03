import '../model/model.dart';

  class TaskController  {
    final List<Task> _tasks = <Task>[];

    List<Task> get tasks => _tasks;

    void addTask(String title){
      _tasks.add(Task(title: title));
    }

    void updateTask(int index, String title){
      _tasks[index].title = title;
    }

    void deleteTask(int index){
      _tasks.removeAt(index);
    }

    void toggleTaskCompletion(int index, bool isCompleted){
      _tasks[index].isCompleted = isCompleted;
    }
  }