import 'dart:html';

import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(title: 'ToDo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> _todos = [];
  final _biggerFont = const TextStyle(
      fontSize: 18.0, color: Colors.black87, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (BuildContext context, int count) {
          Todo todo = _todos[count];

          return ListTile(
            title: Text(
              todo.title.toString(),
              style: _biggerFont,
            ),
            trailing: const Icon(
              Icons.apps_rounded,
              color: Colors.black87,
              semanticLabel: 'M',
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _todoForm(null),
        tooltip: 'Criar Todo',
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add),
      )
    );
  }

  void _todoForm (int? todoIndex) {

    final _formKey = GlobalKey<FormState>();
    Todo? todo = todoIndex != null
        ? _todos[todoIndex]
        : null;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cadastro de Todo'),
              backgroundColor: Colors.redAccent,
            ),
            body: Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * .8,
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Título',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor informe o título';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          maxLines: 3,
                          decoration: const InputDecoration(
                              labelText: 'Descrição'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor informe a descrição';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context, true);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Dados inválidos')),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Salvar',
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
