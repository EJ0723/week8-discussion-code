/*
  Created by: Claizel Coubeili Cepe
  Date: updated April 26, 2023
  Description: Sample todo app with Firebase 
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:week7_networking_discussion/api/firebase_todo_api.dart';
import '../models/todo_model.dart';

class TodoListProvider with ChangeNotifier {
  late FirebaseTodoAPI firebaseService;
  late Stream<QuerySnapshot> _todosStream;

  TodoListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
  }

  // getter
  Stream<QuerySnapshot> get todo => _todosStream;

  fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  Future<void> addTodo(Todo item) async {
    // _todoList.add(item);
    String message = await firebaseService.addTodo(item.toJson(item));
    print(message);
    notifyListeners();
  }

  Future<void> editTodo(String id, String newTitle) async {
    // _todoList[index].title = newTitle;
    String message = await firebaseService.editTodo(id, newTitle);
    print(message);
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    String message = await firebaseService.deleteTodo(id);
    print(message);
    notifyListeners();
  }

  Future<void> toggleStatus(String id, bool status) async {
    // _todoList[index].completed = status;
    String message = await firebaseService.toggleStatus(id, status);
    print(message);
    notifyListeners();
  }
}
