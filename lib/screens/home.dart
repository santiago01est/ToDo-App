import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoslist = ToDo.toDoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: tdBGBColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 50),
                      child: Text(
                        'All ToDos',
                        style: TextStyle(
                            color: tdBlack,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (ToDo todoo in _foundToDo.reversed)
                      ToDoItem(
                        todo: todoo,
                        onToDoChanged: _handleTodoChanged,
                        onDeleteItem: _deleteTodo,
                      ),
                  ],
                ),
              )
            ]),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: 'Add a new ToDo',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8)),
                    ),
                  )),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      child: const Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      onPressed: () {
                        _addTodo(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlueDark,
                        minimumSize: const Size(60, 60),
                        elevation: 10,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void _handleTodoChanged(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodo(String id) {
    setState(() {
      todoslist.removeWhere((item) => item.id == id);
    });
  }

  void _addTodo(String toDo) {
    setState(() {
      todoslist.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoslist;
    } else {
      results = todoslist
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: tdGrey,
            height: 1.5, // Ajusta este valor según sea necesario
          ),
        ),
      ),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: tdBGBColor,
    elevation: 0,
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Icon(
        Icons.menu,
        color: tdBlack,
        size: 30,
      ),
      Container(
        height: 40,
        width: 40,
        child: CircleAvatar(
            radius: 20, backgroundImage: AssetImage('assets/images/icono.png')),
      )
    ]),
  );
}
