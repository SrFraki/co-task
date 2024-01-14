import 'package:flutter/material.dart';
import 'package:task_sharing/config/theme/theme.dart';
import 'package:text_scroll/text_scroll.dart';

class UsersTaskInfo extends StatelessWidget {
  const UsersTaskInfo({
    super.key,
    this.name = '',
    this.task = const [],
    this.isCompleted = const [false]
  });

  final List<String> task;
  final List<bool> isCompleted;
  final String name;

  @override
  Widget build(BuildContext context) {

    final width = (MediaQuery.of(context).size.width - 98 - 60)/3;

    return Card(
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        height: 50,
        child: Row(
          children: [
            SizedBox(
              width: width,
              child: Text(
                name.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  color: ATheme.darkMode ? Colors.white70 : Colors.black
                ),
              ),
            ),

            // const Spacer(),

            Expanded(
              // padding: const EdgeInsets.only(right: 10),
              // width: ,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: TextScroll(
                  task.fold<String>('', (p, e) => p != '' ? '$p / $e' : e),
                  style: TextStyle(
                    fontSize: 16,
                    color: ATheme.darkMode ? Colors.white54 : Colors.black
                  ),
                  intervalSpaces: 10,
                  mode: TextScrollMode.endless,
                  textAlign: TextAlign.end,
                  fadedBorder: true,
                  fadedBorderWidth: 0.1,
                  velocity: const Velocity(pixelsPerSecond: Offset(35,0)),
                  pauseBetween: const Duration(seconds: 1),
                ),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 50,
              width: 50,
              color: isCompleted.fold(true, (p, e) => p && e) ? Colors.green.shade300 : ATheme.darkMode ? Colors.red.shade300 : Colors.red.shade200,
              child: Icon(
                isCompleted.fold(true, (p, e) => p && e) ? Icons.done_rounded : Icons.close_rounded, 
                color: isCompleted.fold(true, (p, e) => p && e) ? Colors.green.shade100 : Colors.red.shade100),
            )
            
          ],
        ),
      ),
    );
  }
}