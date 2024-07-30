import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lista de tarefas",
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class Task {
  String title;
  bool isCompleted;

  Task(this.title, this.isCompleted);
}

class MyHomeState extends State<MyHome> {
  final TextEditingController taskController = TextEditingController();
  List<Task> _tasks = <Task>[];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                        hintText: "Digite aqui a nova tarefa...",
                        hintStyle: TextStyle(fontSize: 20)),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'O campo de Tarefa é obrigatório';
                      }
                    },
                    controller: taskController,
                  )),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _tasks.add(Task(taskController.text, false));
                          });
                          taskController.clear();
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: ((context, index) {
                return Card(
                    child: ListTile(
                  title: Text(
                    _tasks[index].title,
                    style: TextStyle(
                      decoration: _tasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      TextEditingController editController =
                          TextEditingController(text: _tasks[index].title);

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Editar Tarefa"),
                              content: TextFormField(
                                controller: editController,
                                decoration: InputDecoration(
                                    hintText: "Digite a nova tarefa"),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Cancelar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Salvar"),
                                  onPressed: () {
                                    setState(() {
                                      _tasks[index].title = editController.text;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                  leading: Checkbox(
                      value: _tasks[index].isCompleted,
                      onChanged: (bool? value) {
                        setState(() {
                          _tasks[index].isCompleted = value!;
                        });
                      }),
                ));
              }),
              itemCount: _tasks.length,
            ))
          ],
        ),
      ),
    );
  }
}
