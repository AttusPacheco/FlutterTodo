import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:date_field/date_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> _todos = <Todo>[];
  final _biggerFont = const TextStyle(
      fontSize: 18.0, color: Colors.black87, fontWeight: FontWeight.normal
  );

  @override
  void initState() {
    _todos = <Todo>[];

    super.initState();
  }

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
                ));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            _todoForm(null);
          }),
          tooltip: 'Criar Todo',
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
        ));
  }

  void _todoForm(int? todoIndex) {
    final _formKey = GlobalKey<FormState>();
    Todo? todo = todoIndex != null ? _todos[todoIndex] : Todo.init();

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
                            onSaved: (value) {
                              todo.title = value!;
                            },
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Descrição'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor informe a descrição';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              todo.description = value!;
                            }
                          ),
                          const SizedBox(height: 30),
                          DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              fillColor: Colors.redAccent,

                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Data',
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.always,
                            onSaved: (value) {
                              todo.date = value.toString();
                            },
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent,
                              shadowColor: Colors.black87,
                              textStyle: const TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _formKey.currentState!.save();

                                  _todos.add(todo);
                                  Navigator.pop(context, true);
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Dados inválidos')
                                  ),
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
