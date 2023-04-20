
/*
 * PROVIDER
 * Provides all the information of the app and maintains the state
 */

import 'package:flutter/material.dart';
import 'package:todo_list_app/src/db/db_provider.dart';
import 'package:todo_list_app/src/db/db_tables.dart';
import 'package:todo_list_app/src/helpers/helpers.dart';
import 'package:uuid/uuid.dart';
import '../models/todo.dart';

class TodosProvider extends ChangeNotifier{

  // database
  final _database = DBProvider.db;

  // todo list
  List<Todo> todos = [];

  // current todo
  late Todo _currentTodo;

  Todo get currentTodo => _currentTodo;

  set currentTodo(Todo value) {
    _currentTodo = value;
    notifyListeners();
  }

  List<Todo> get pending => todos.where( (t) => t.isCompleted == 0 ).toList();
  List<Todo> get    done => todos.where( (t) => t.isCompleted == 1 ).toList();

  TodosProvider(){
    getTodos();
  }

  // get all todos
  Future<void> getTodos() async {
    try {
      final db = await _database.database;
      final todosQuery = await db.query(Tables.todos.name);

      if( todosQuery.isNotEmpty ){
        todos = todosQuery.map(( todoMap ) => Todo.fromMap( todoMap ) ).toList();
        notifyListeners();
      }else{
        todos = [];
        notifyListeners();
      }
    } catch (_) {}
  }

  // Create or update todo 
  Future<void> createOrUpdateTodo() async {
    try {
      if( currentTodo.id == null ){
        await createTodo();
      }else{ 
        await updateTodo();
      }

      await getTodos();

    } catch ( _ ) {}
  }

  // Create new todo
  Future<void> createTodo() async {
    try {
      final db = await _database.database;

      const uuid = Uuid();
      currentTodo = currentTodo.copyWith( id: uuid.v4());
      await db.insert( Tables.todos.name , currentTodo.toMap() );
    } catch (_){}
  }

  // Update todo
  Future<void> updateTodo() async {
    try {
      final db = await _database.database;
      await db.update(
        Tables.todos.name, 
        currentTodo.toMap() ,
        where: 'id=?', 
        whereArgs: [ currentTodo.id ] 
      );

    } catch (_) {}
  }

  // Delete todo
  Future<void> deleteTodo({ required Todo todo }) async {
    try {
      final db = await _database.database;
      await db.delete( Tables.todos.name, where: 'id=?', whereArgs: [ todo.id ]);
      if( todo.path.isNotEmpty ){
        await Helpers.deleteImage( todo.path );
      }
      await getTodos();
    } catch (_) {}
  }


}