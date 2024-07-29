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

class MyHomeState extends State<MyHome> {
  final TextEditingController taskController = TextEditingController();
  List<String> _tasks = <String>[];
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
                          _tasks.add(taskController.text);

                          });
                          taskController.clear();
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Cor do botão
                        foregroundColor: Colors.white, // Cor do texto
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
                  title: Text(_tasks[index]),
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
