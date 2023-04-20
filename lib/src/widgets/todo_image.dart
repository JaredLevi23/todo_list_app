
import 'dart:io';

import 'package:flutter/material.dart';

class TodoImage extends StatelessWidget {

  final String path;
  const TodoImage({ Key? key, required this.path }) : super(key: key);

  @override
  Widget build(BuildContext context){

    return ClipRRect(
        borderRadius: BorderRadius.circular( 15 ),
        child: path.isEmpty 
        ? Container( color: Colors.grey, child: const Icon( Icons.photo ))
        : Image.file( File( path ), fit: BoxFit.cover, )
    );
  }
}