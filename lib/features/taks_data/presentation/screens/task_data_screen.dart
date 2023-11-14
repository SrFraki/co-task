import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sharing/features/taks_data/presentation/providers/task_provider.dart';

import '../../domain/models/task.dart';

class TaskDataScreen extends ConsumerWidget {
  const TaskDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskPProvider);


    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.all(40),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TaskCard(
              task: state.task,
              onPressed: ref.read(taskPProvider.notifier).toggleComplete,
              width: 1.sw,
              height: 0.9.sw,
            ),
          ],
        ),
      ),
    );
  }
}



class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.onPressed,
    required this.width,
    required this.height,
  });

  final Task task;
  final VoidCallback onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    
    // return Card(
      // elevation: 1,
      // margin: EdgeInsets.zero,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // color: Colors.red,
    // );

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.task,
                    style: TextStyle(
                      fontSize: 25.spMax,
                      fontWeight: FontWeight.w400,
                      color: colors.onBackground.withOpacity(0.8)
                    ),
                  ),
          
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: colors.surfaceVariant,
                        padding: const EdgeInsets.all(15),
                        child: Icon(
                          task.icon,
                          size: width*0.45,
                        ),
                      ),
                    ),
                  ),
          
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: task.isCompleted ? colors.primaryContainer : colors.tertiaryContainer,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                      elevation: 0,
                      padding: EdgeInsets.zero
                    ),
                    onPressed: onPressed, 
                    child: SizedBox(
                      height: 60,
                      child: Center(child: Text(
                        task.isCompleted ? 'COMPLETADO' : 'NO COMPLETADO',
                        style: TextStyle(
                          color: !task.isCompleted ? colors.secondary : Colors.white,
                          fontSize: 18.spMax
                        ),
                      ))
                    )
                  )
                ],
              ),
            ),

            if(task.isCompleted)
              GestureDetector(
                onTap: onPressed,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    width: 1.sw,
                    height: 1.sh,
                    child: Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.white.withOpacity(0.7),
                      size: 0.5.sw,
              
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}



// Column(
//           children: [
//             Text(
//               task.task,
//               style: TextStyle(
//                 fontSize: 25.spMax,
//                 fontWeight: FontWeight.w400,
//                 color: colors.onBackground.withOpacity(0.8)
//               ),
//             ),

//             ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: Container(
//                 color: colors.surfaceVariant,
//                 padding: const EdgeInsets.all(15),
//                 child: Icon(
//                   task.icon,
//                   size: size.width/2,
//                 ),
//               ),
//             ),

//             TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: task.isCompleted ? colors.primaryContainer : colors.tertiaryContainer,
//                 shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(15),
//                   bottomRight: Radius.circular(15),
//                 )),
//                 elevation: 0,
//                 padding: EdgeInsets.zero
//               ),
//               onPressed: onPressed, 
//               child: SizedBox(
//                 height: 60,
//                 child: Center(child: Text(
//                   task.isCompleted ? 'COMPLETADO' : 'NO COMPLETADO',
//                   style: TextStyle(
//                     color: !task.isCompleted ? colors.secondary : Colors.white,
//                     fontSize: 18.spMax
//                   ),
//                 ))
//               )
//             )
//           ],
//         ),
