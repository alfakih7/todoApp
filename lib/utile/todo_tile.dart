import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskname;
  final bool tascompleted;
  Function(bool?)? onchanged;
  Function(BuildContext)? deleteFunction;

  TodoTile(
      {super.key,
      required this.taskname,
      required this.tascompleted,
      required this.onchanged,
      required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25,
        top: 25,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(13),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              //check box
              Checkbox(
                value: tascompleted,
                onChanged: onchanged,
                activeColor: Colors.black,
              ),

              //task name

              Text(taskname,
                  style: TextStyle(
                    decoration: tascompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
