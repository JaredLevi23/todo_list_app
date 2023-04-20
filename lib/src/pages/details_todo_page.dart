/*
 *  Page: DetailsTodoPage
 *  Function: Display the details of the current todo
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/src/providers/todos_provider.dart';
import 'package:todo_list_app/src/widgets/todo_image.dart';
import 'package:todo_list_app/src/widgets/widgets.dart';

class DetailsTodoPage extends StatelessWidget {
  const DetailsTodoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    // providers
    final todoProvider = Provider.of<TodosProvider>(context);
    // todo
    final todo = todoProvider.currentTodo;

    return Scaffold(

      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'create'), 
            icon: const Icon( Icons.edit )
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 10 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // date time
            Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.only( bottom: 25 ),
              child: Center(
                child: Text( todo.dateTime.toString().split(' ')[0] ,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            // image
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                child: TodoImage(
                  path: todo.path
                ),
              ),
            ),

            const SizedBox(
              height: 15
            ),

            const Text('Description'),

            // description
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Text(
                todo.description,
                style: const TextStyle( fontSize: 19, fontStyle: FontStyle.italic ),
                
              )
            ),

            const SizedBox(
              height: 20,
            ),

            // checkbox
            CustomCheckbox(
              value: todo.isCompleted == 1, 
              onChanged: ( value ) async {
                if(value == true){
                  todoProvider.currentTodo = todo.copyWith( isCompleted: 1 );
                }else{
                  todoProvider.currentTodo = todo.copyWith( isCompleted: 0);
                }
                await todoProvider.createOrUpdateTodo();
              }
            )

          ],
        ),
      )
    );
  }
}