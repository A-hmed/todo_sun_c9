import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sun_c9/models/todo_dm.dart';
import 'package:todo_sun_c9/ui/providers/list_provider.dart';
import 'package:todo_sun_c9/ui/utils/app_colors.dart';
import 'package:todo_sun_c9/ui/utils/app_theme.dart';
import 'package:todo_sun_c9/ui/widgets/my_text_field.dart';

class AddBottomSheet extends StatefulWidget {

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Add New task", textAlign: TextAlign.center,
          style: AppTheme.bottomSheetTitleTextStyle,),
          const SizedBox(height: 16,),
          MyTextField(hintText: "Enter task title", controller: titleController,),
          const SizedBox(height: 8,),
          MyTextField(hintText: "Enter task description", controller: descriptionController,),
           const SizedBox(height: 16,),
           Text("Select date",
              style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.w600)),
           InkWell(
              onTap: (){
                showMyDatePicker();
              },
             child: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                textAlign: TextAlign.center,
                style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.normal,
                    color: AppColors.grey)),
           ),
          const Spacer(),
          ElevatedButton(onPressed: (){
            addTodoToFirestore();
          },
              child: const Text("Add"))
        ],
      ),
    );
  }

  void addTodoToFirestore()  {

   CollectionReference todosCollectionRef =
   FirebaseFirestore.instance.collection(TodoDM.collectionName);

   DocumentReference newEmptyDoc = todosCollectionRef.doc();
   newEmptyDoc.set({
       "id": newEmptyDoc.id,
       "title": titleController.text,
       "description": descriptionController.text,
       "date": selectedDate,
       "isDone": false,
   }).timeout(Duration(milliseconds: 300), onTimeout: (){
     provider.refreshTodosList();
     Navigator.pop(context);
   });
   //todosCollectionRef.add();
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))) ?? selectedDate;
    setState(() {});

  }
}
/// Json -> Java script object notation
/// {key: value}
/// key - > String
/// value -> String, number, bool, null, timestamp , json, List<Json>