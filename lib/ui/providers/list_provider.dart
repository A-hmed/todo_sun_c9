import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_sun_c9/models/todo_dm.dart';

class ListProvider extends ChangeNotifier{
  List<TodoDM> todos = [];
  DateTime selectedDate = DateTime.now();

  refreshTodosList() async {
    CollectionReference<TodoDM> todosCollection =
    FirebaseFirestore.instance.collection(TodoDM.collectionName).
    withConverter<TodoDM>(
        fromFirestore: (docSnapShot, _) {
          Map json = docSnapShot.data() as Map;
          TodoDM todo = TodoDM.fromJson(json);
          return todo;
        },
        toFirestore: (todoDm, _){
          return todoDm.toJson();
        });
    QuerySnapshot<TodoDM> todosSnapshot = await todosCollection.
    orderBy("date").
   // where("date", isEqualTo: selectedDate).
    get()
    ;

    List<QueryDocumentSnapshot<TodoDM>> docs = todosSnapshot.docs;
    // for (int i = 0; i < docs.length; i++) {
    //   todos.add(docs[i].data());
    // }
    ///Better solution
    todos = docs.map( (docSnapshot){
      return docSnapshot.data();
    }).toList();
    // for(int i = 0; i< todos.length ;i++){
    //   /// i = 0 [1, 2, 3] - > [2,3]
    //   /// i = 1 length 2; [2,3];
    //   print("Title:${todos[i].title} todos[i].date.day: ${todos[i].date.day}, selectedDate.day:${selectedDate.day}");
    //   if(todos[i].date.day != selectedDate.day ||
    //       todos[i].date.month != selectedDate.month ||
    //      todos[i].date.year != selectedDate.year){
    //     todos.removeAt(i);
    //     i--;
    //   }
    // }
    /// Better sol.
    todos = todos.where((todo){
        if(todo.date.day != selectedDate.day ||
            todo.date.month != selectedDate.month ||
           todo.date.year != selectedDate.year){
          return false;
        }else {
          return true;
        }
    }).toList();
    // todos.sort((todo1, todo2){
    //
    // })
    notifyListeners();
  }
}