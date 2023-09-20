import 'package:flutter/material.dart';
import 'package:todo_app/widgets/todo_item.dart';
import 'package:todo_app/model/todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Add a new ToDo item',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 40),
                  ),
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    //to complete the task
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    //It will delete the task
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    if (!toDo.isEmpty) {
      //add a new task
      setState(() {
        todoList.add(ToDo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: toDo));
        _todoController.clear();
      });
    }
  }

  void _runFilter(String keyword) {
    List<ToDo> results = [];
    if (keyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 21,
          ),
          // prefixIconConstraints:
          //     BoxConstraints(maxHeight: 20, minWidth: 25),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.grey.shade200,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: Colors.black,
          ),
          Image.asset(
            'images/tick.png',
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }
}
