import 'package:flutter/material.dart';
import 'package:todo_list_app/src/widgets/todo_image.dart';

import '../models/todo.dart';

class TodoTile extends StatelessWidget {

  final Todo todo;
  final Function()? onPressed;
  final Function()? onLongPress;

  const TodoTile({
    super.key,
    required this.todo,
    this.onPressed,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only( top: 5 ), 
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( 15 )
        ),
        title: Text( todo.description, maxLines: 2, overflow: TextOverflow.ellipsis, ),
        subtitle: Text( todo.dateTime.toString().split(' ')[0] ),
        trailing: const Icon( Icons.arrow_forward_ios ),
        leading: Container(
          width: 50,
          height: 90,
          child: TodoImage(path: todo.path )
        ),
        onTap: onPressed,
        onLongPress: onLongPress,
      ),
    );
  }
}