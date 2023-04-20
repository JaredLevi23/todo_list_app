/*
 * Main
 * Function: Application Start
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/src/theme/theme.dart';

import './src/pages/pages.dart';
import './src/providers/todos_provider.dart';

void main() {
  runApp( const Main() );
}

class Main extends StatelessWidget {
const Main({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [

        // provider to do list
        ChangeNotifierProvider(create: (_) => TodosProvider() ) 

      ],
      child: const TodoListApp(),
    );
  }
}

class TodoListApp extends StatelessWidget {
const TodoListApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'create': (_) => const CreateTodoPage(),
        'details': (_) => const DetailsTodoPage(),
        'home'  : (_) => const HomePage(),
      },
      theme: TodoListAppTheme.getTheme(),
    );
  }
}