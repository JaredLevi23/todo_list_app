
/*
 * Page: Home Page 
 * Function: Show to do list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/src/models/todo.dart';
import 'package:todo_list_app/src/providers/todos_provider.dart';

// widgets
import '../widgets/widgets.dart'; 

class HomePage extends StatelessWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    // provider
    final todosProvider = Provider.of<TodosProvider>(context);

    return Scaffold(

      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.add ),
        onPressed: (){

          todosProvider.currentTodo = Todo(
            path: '',
            description: '', 
            dateTime: DateTime.now(), 
            isCompleted: 0
          );

          Navigator.pushNamed(context, 'create');
        }
      ),

      // todo list
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text( 'To do',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),

              if( todosProvider.pending.isEmpty )
              const _TextState(
                label: 'Nothing here!',
                color: Colors.green,
              ),

              ...todosProvider.pending.map(( todo ) => TodoTile(
                todo: todo,
                onPressed: () {
                  todosProvider.currentTodo = todo;
                  Navigator.pushNamed(context, 'details');
                },
                onLongPress: (){
                  showDialog(
                    context: context, 
                    builder: (_) => AlertDialog(
                      title: const Text('Options'),
                      content: Text('${ todo.dateTime.toString().split(' ')[0] } - ${ todo.description }', maxLines: 2,),
                      actions: [
                        TextButton(
                          child: const Text('Delete'),
                          onPressed: () async {
                            final navigator = Navigator.of(context);
                            todosProvider.deleteTodo( todo: todo );
                            navigator.pop();
                          }, 
                        )
                      ],
                    )
                  );
                }
              )).toList(),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text( 'Done',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),


              if( todosProvider.done.isEmpty )
              const _TextState(
                label: 'Create a note',
                color: Colors.indigo,
              ),


              ...todosProvider.done.map(( todo ) => TodoTile(
                todo: todo,
                onPressed: () {
                  todosProvider.currentTodo = todo;
                  Navigator.pushNamed(context, 'details');
                },
                onLongPress: (){
                  showDialog(
                    context: context, 
                    builder: (_) => AlertDialog(
                      title: const Text('Options'),
                      content: Text('${ todo.dateTime.toString().split(' ')[0] } - ${ todo.description }', maxLines: 2,),
                      actions: [
                        TextButton(
                          child: const Text('Delete'),
                          onPressed: () async {
                            final navigator = Navigator.of(context);
                            todosProvider.deleteTodo( todo: todo );
                            navigator.pop();
                          }, 
                        )
                      ],
                    )
                  );
                },
        
            )).toList(),
      
            ],
          ),
        ),
      )
    );
  }
}

class _TextState extends StatelessWidget {

  final String label;
  final Color? color;

  const _TextState({
    required this.label, 
     this.color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text( label ,
        style: TextStyle(
          fontSize: 25,
          color: color ?? Colors.green,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.italic
        )
      ),
    );
  }
}

class _TodosEmpty extends StatelessWidget {

  const _TodosEmpty();

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Create a to do reminder', style: TextStyle( fontSize: 18 ),),
      );
  }
}

