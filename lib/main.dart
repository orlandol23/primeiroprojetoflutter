import 'package:flutter/material.dart';
import 'view/view.dart';
import 'controller/controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    TaskController controller = TaskController();
    return MaterialApp(
      title: "Lista de Tarefas",
      home: TaskView(controller),
    );
  }
}