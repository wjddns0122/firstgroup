import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class TodoModel {
  final String? id;
  final String todo;
  final Timestamp? time;
  final bool? isDone;

  TodoModel({this.id, required this.todo, this.time, this.isDone});

  factory TodoModel.fromJson(DocumentSnapshot doc) {
    return TodoModel(
        id: doc.id,
        todo: doc['todo'],
        time: doc['time'],
        isDone: doc['isDone']);
  }

  factory TodoModel.toJson(String todo) {
    return TodoModel(todo: todo);
  }
}

class CategoryModel {
  final String name;
  final Widget page;

  CategoryModel({required this.name, required this.page});
}
