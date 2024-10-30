import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc/cubit/todo_cubit.dart';
import 'package:todo_bloc/home.dart';
import 'package:todo_bloc/models/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  final todoBox = await Hive.openBox<Todo>('mybox');
  runApp(
    (MyApp(todoBox: todoBox)),
  );
}

class MyApp extends StatelessWidget {
  final Box<Todo> todoBox;
  const MyApp({super.key, required this.todoBox});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoBox),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomeScreen(),
      ),
    );
  }
}
