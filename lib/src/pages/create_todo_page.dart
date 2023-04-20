
/*
 * Page: Create Todo Page 
 * Function: Page where notes to do are saved
*/

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart'
;
import 'package:todo_list_app/src/helpers/helpers.dart';
import 'package:todo_list_app/src/providers/todos_provider.dart';
import 'package:todo_list_app/src/ui/input_decorations.dart';
import 'package:todo_list_app/src/widgets/todo_image.dart';
import 'package:todo_list_app/src/widgets/widgets.dart';

class CreateTodoPage extends StatelessWidget {

  const CreateTodoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    // provider
    final todoProvider = Provider.of<TodosProvider>(context);
    // current todo
    final todo = todoProvider.currentTodo;

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title: Text( todo.id == null ? 'Create': 'Update' ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 10 ),
        child: Column(
          children: [

            // selecter date
            GestureDetector(
              child: Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.only( bottom: 15 ),
                decoration: BoxDecoration(
                  border: Border.all( width: 1, color: Colors.grey ),
                  borderRadius: BorderRadius.circular( 15 )
                ),
                child: Center(
                  child: Text( 
                    todo.dateTime.toString().split(' ')[0], 
                    style: const TextStyle( 
                      fontSize: 17 
                    ) 
                  )
                ),
              ),
              onTap: () async {
                final pickerDate = await showDatePicker(
                  context: context, 
                  initialDate: todo.dateTime, 
                  firstDate: DateTime( 2022, 01, 01 ), 
                  lastDate: DateTime( 2029, 12, 31 )
                );

                if( pickerDate != null ){
                  todoProvider.currentTodo = todo.copyWith( dateTime: pickerDate );
                }
              },
            ),

            // textformfield description
            TextFormField(
              initialValue: todo.description,
              decoration: InputDecorations.textFormFieldDecoration(
                hintText: 'Description'
              ),
              maxLines: 7,
              onChanged: ( value ){
                todoProvider.currentTodo = todo.copyWith( description: value );
              },
            ),

            const SizedBox(
              height: 15,
            ),

            // checkbox tile
            CustomCheckbox(
              value: todo.isCompleted == 1, 
              onChanged: ( value ){
                if(value == true){
                  todoProvider.currentTodo = todo.copyWith( isCompleted: 1 );
                }else{
                  todoProvider.currentTodo = todo.copyWith( isCompleted: 0 );
                }
              }
            ),

            const SizedBox(
              height: 15,
            ),

            // Add image
            ListTile(
              title: const Text('Add image'),
              leading: SizedBox(
                width: 50,
                height: 90,
                child: TodoImage(path: todo.path )
              ),

              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final img = await Helpers.pickImageFrom(source: ImageSource.camera);
                        if( img != null ){
                          todoProvider.currentTodo = todo.copyWith( path: img );
                        }
                      }, 
                      icon: const Icon( Icons.camera_alt_rounded )
                    ),
                    IconButton(
                      onPressed: () async {
                        final img = await Helpers.pickImageFrom(source: ImageSource.gallery);
                        if( img != null ){
                          todoProvider.currentTodo = todo.copyWith( path: img );
                        }
                      }, 
                      icon: const Icon( Icons.photo 
                    ))
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            // save button
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Save',
                    backgroundColor: Colors.blue,
                    onPressed: () async{
                      // create or update current todo
                      final navigator = Navigator.of(context);
                      await todoProvider.createOrUpdateTodo();
                      navigator.pop();
                    },
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    label: 'Cancel',
                    backgroundColor: Colors.redAccent,
                    onPressed: ()=> Navigator.pop(context),
                  ),
                ),
              ],
            ),


          ],
        ),
      )
    );
  }
}