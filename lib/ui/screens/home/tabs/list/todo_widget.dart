import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_sun_c9/ui/utils/app_colors.dart';
import 'package:todo_sun_c9/ui/utils/app_theme.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),
          color: AppColors.white),
      margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          extentRatio: .25,
          children: [
            SlidableAction(
              onPressed: (_){},
              backgroundColor: Colors.red,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          height: MediaQuery.of(context).size.height * .13,
          child: Row(
            children: [
              const VerticalDivider(),
              const SizedBox(width: 12,),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Play basketball", style: AppTheme.taskTitleTextStyle,),
                    Text("Description",
                      textAlign: TextAlign.start,
                      style: AppTheme.taskDescriptionTextStyle,)
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  color: AppColors.primiary,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: const Icon(Icons.check, color: AppColors.white,))
            ],
          ),
        ),
      ),
    );
  }
}
