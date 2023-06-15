import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final todoslist = ToDo.toDoList();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: tdBGBColor,
      appBar: _buildAppBar(),
      body: Container(
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
                for (ToDo todoo in todoslist)
                  ToDoItem(
                    todo: todoo,
                  ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

Widget searchBox() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: const TextField(
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
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset('assets/images/icono.png')),
      )
    ]),
  );
}
