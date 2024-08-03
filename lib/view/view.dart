import 'package:flutter/material.dart';
import '../controller/controller.dart';
import '../model/model.dart';

class TaskView extends StatefulWidget {
  final TaskController controller;

  const TaskView(this.controller, {super.key});

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView>{
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de tarefas"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.black87,
                      ),
                      decoration: const InputDecoration(
                          hintText: "Digite aqui a nova tarefa...",
                          hintStyle: TextStyle(fontSize: 20)),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'O campo de Tarefa é obrigatório';
                        }
                      },
                      controller: taskController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            widget.controller.addTask(taskController.text);
                          });
                          taskController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: ((context, index) {
                Task task = widget.controller.tasks[index];
                return Card(
                    child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          TextEditingController editController =
                              TextEditingController(text: task.title);

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Editar Tarefa"),
                                  content: TextFormField(
                                    controller: editController,
                                    decoration: const InputDecoration(
                                        hintText: "Digite a nova tarefa"),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Cancelar"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Salvar"),
                                      onPressed: () {
                                        setState(() {
                                          widget.controller.updateTask(index, editController.text);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      ),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              widget.controller.deleteTask(index);
                            });
                          }),
                    ],
                  ),
                  leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.controller.toggleTaskCompletion(index, value!);
                        });
                      }),
                ));
              }),
              itemCount: widget.controller.tasks.length,
            ))
          ],
        ),
      ),
    );
  }
}