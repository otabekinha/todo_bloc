import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_bloc/cubit/todo_cubit.dart';
import 'package:todo_bloc/models/todo_model.dart';
import 'package:todo_bloc/screens/new_todo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        title: const Text('Todos'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NewTodo()),
              );
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Slidable(
                endActionPane: ActionPane(
                  extentRatio: 1,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.green,
                      onPressed: (context) async {
                        final todoCubit = context.read<TodoCubit>();
                        String? newTitle = await showDialog<String>(
                          context: context,
                          builder: (context) {
                            TextEditingController controller =
                                TextEditingController(text: todo.title);
                            return AlertDialog(
                              title: const Text('Update Todo'),
                              content: TextField(
                                controller: controller,
                                decoration: const InputDecoration(
                                    hintText: 'Enter new title'),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, controller.text),
                                  child: const Text('Update'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );

                        if (newTitle != null && newTitle.isNotEmpty) {
                          todoCubit.updateTodo(index, newTitle);
                        }
                      },
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      backgroundColor: Colors.red,
                      onPressed: (context) {
                        context.read<TodoCubit>().removeTodo(index);
                      },
                      icon: Icons.remove_circle_outline,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.createdAt.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
