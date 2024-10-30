import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc/models/todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final Box<Todo> todoBox;
  TodoCubit(this.todoBox) : super([]) {
    loadTodos();
  }

  void loadTodos() {
    final todos = todoBox.values.toList();
    emit(todos);
  }

  void addTodo(String title) {
    if (title.isEmpty) {
      addError('Title cannot be empty!');
      return;
    }
    final todo = Todo(
      title: title,
      createdAt: DateTime.now(),
    );

    todoBox.add(todo);
    emit([...state, todo]);
  }

  void removeTodo(int index) {
    todoBox.deleteAt(index);
    final updatedTodos = List<Todo>.from(state)..removeAt(index);
    emit(updatedTodos);
  }

  void updateTodo(int index, String newTitle) {
    final updatedTodo = state[index].copyWith(title: newTitle);
    todoBox.putAt(index, updatedTodo);

    final updatedTodos = List<Todo>.from(state)..[index] = updatedTodo;
    emit(updatedTodos);
  }
}
