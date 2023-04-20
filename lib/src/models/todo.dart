/*
 *   Model
 *   Model todo
 */

import 'dart:convert';

class Todo{

  final DateTime dateTime;
  final int isCompleted;
  final String? id;
  final String description;
  final String path;

  Todo({
    this.id, 
    required this.path, 
    required this.description, 
    required this.dateTime, 
    required this.isCompleted
  });

  factory Todo.fromJson(String str) => Todo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        id: json["id"],
        path: json["path"],
        description: json["description"],
        dateTime: DateTime.parse( json["dateTime"] ),
        isCompleted: json["isCompleted"]
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "path": path,
        "description": description,
        "dateTime": dateTime.toString(),
        "isCompleted": isCompleted
    };

    Todo copyWith({
      String? id,
      String? path,
      String? description,
      DateTime? dateTime,
      int? isCompleted
    })=> Todo(
      id: id ?? this.id,
      path: path ?? this.path,
      description: description ?? this.description, 
      dateTime: dateTime ?? this.dateTime, 
      isCompleted: isCompleted ?? this.isCompleted
    );

}