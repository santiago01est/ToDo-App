class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> toDoList() {
    return [
      ToDo(
        id: '1',
        todoText: 'Buy milk',
        isDone: true,
      ),
      ToDo(
        id: '2',
        todoText: 'Buy bread',
      ),
      ToDo(
        id: '3',
        todoText: 'Buy eggs',
      ),
      ToDo(
        id: '4',
        todoText: 'Cinema tickets',
      ),
      ToDo(
        id: '5',
        todoText: 'Dineer with friends',
      ),
      ToDo(
        id: '6',
        todoText: 'go to gym',
      ),
      ToDo(
        id: '7',
        todoText: 'sleep',
      ),
    ];
  }
}
