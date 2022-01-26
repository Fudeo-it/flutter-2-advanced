import 'package:flutter/material.dart';
import 'package:sqlite/model/todo_model.dart';
import 'package:sqlite/repository/todo_repository.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todoRepository = TodoRepository();
  await todoRepository.initialize();
  GetIt.I.registerSingleton(todoRepository);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoTextFieldController = TextEditingController();
  List<TodoModel> todos = [];

  @override
  void initState() {
    super.initState();

    GetIt.I.get<TodoRepository>().all().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  void createTodo() async {
    final todo = todoTextFieldController.text.trim();
    todoTextFieldController.clear();

    final todoModel = await GetIt.I.get<TodoRepository>().create(todo);

    setState(() {
      todos.add(todoModel);
    });
  }

  void removeTodo(TodoModel todo) {
    setState(() {
      todos.removeWhere((it) => it.id == todo.id);
    });

    GetIt.I.get<TodoRepository>().delete(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: todoTextFieldController,
          decoration: InputDecoration(
            hintText: "Cosa desideri ricordarti di fare?",
          ),
        ),
        actions: [
          IconButton(
            onPressed: createTodo,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: todos.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(todos[index].text),
          trailing: IconButton(
            onPressed: () => removeTodo(todos[index]),
            icon: Icon(Icons.delete),
          ),
        ),
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
