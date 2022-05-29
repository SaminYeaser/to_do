import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Task extends Equatable{
   String? title;
   IconData? icon;
   Color? color;
   List<dynamic>? todos;

   Task({ this.title,this.icon,this.color,this.todos});

  Task copyWith({
    String? title,
    IconData? icon,
    Color? color,
    List<dynamic>? todos
  }) =>Task(
          title: title ?? this.title,
          icon: icon ?? this.icon,
          color: color ?? this.color,
          todos: todos ?? this.todos);

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      todos: json['todos']);

  Map<String, dynamic> toJson()=>{
    'title': title,
    'icon': icon,
    'color' :color,
    'todos': todos,
  };

  @override
  List<Object?> get props => [title, icon, color];
}
