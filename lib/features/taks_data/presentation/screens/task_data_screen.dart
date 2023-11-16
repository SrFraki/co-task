import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:task_sharing/features/taks_data/presentation/providers/task_provider.dart';

import '../../domain/models/task.dart';

class TaskDataScreen extends ConsumerWidget {
  const TaskDataScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskPProvider);
    int n = state.tasks.length;
    double w = (1.sw-90)/2;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(30),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        // child: ListView.builder(
        //   itemCount: state.tasks.length,
        //   itemBuilder: (context, index) {
        //     final size = getSize(state.tasks.length);
        //     return Padding(
        //       padding: EdgeInsets.only(bottom: index == state.tasks.length-1 ? 0 : 50),
        //       child: _TaskCard(
        //         task: state.tasks[index],
        //         onPressed: () => ref.read(taskPProvider.notifier).toggleComplete(index),
        //         width: size.width,
        //         // width: 1.sw,
        //         // height: 0.9.sw,
        //         height: size.height,
        //       ),
        //     );
        //   },
        // ),
        child: n <= 2 
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              for(int index = 0; index < n; index++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(n!=1 && index%2==1)
                      const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: index == 1 ? 30 : 0),
                      child: _TaskCard(
                        task: state.tasks[index],
                        onPressed: () => ref.read(taskPProvider.notifier).toggleComplete(index),
                        width: n == 2 ? ((1.sw-90)/2)*1.5 : ((1.sw-90)/2)*2,    //  1 -> 0.8.sw       2 ->0.6.sw
                      ),
                    ),
                    if(n!=1 && index%2==0)
                      const Spacer()
                  ],
                ),
            ],
        )
        : MasonryGridView.count(
            crossAxisCount: 2, 
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            itemCount: n,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: index == 1 ? (1.sw-90)/4 : 0),
                child: _TaskCard(
                  task: state.tasks[index],
                  onPressed: () => ref.read(taskPProvider.notifier).toggleComplete(index),
                  width: (1.sw-90)/2,
                ),
              );
            },
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
  });

  final Task task;
  final VoidCallback onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final tStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: task.isCompleted ? Colors.white38 : Colors.white70,
      fontSize: 16
    );


    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox.square(
                dimension: width,
                child: Container(
                  // margin: const EdgeInsets.all(15),
                  margin: EdgeInsets.all((2.2*width/1.sw)*15),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Icon(
                    task.icon,
                    size: width*0.5,
                    color: task.isCompleted ? colors.primary.withOpacity(0.2) : colors.tertiary.withOpacity(0.8),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: (2.2*width/1.sw)*22),
                child: Text(
                  task.task,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tStyle,
                  textScaleFactor: (2.2*width)/1.sw,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: onPressed, 
            style: TextButton.styleFrom(
              backgroundColor: task.isCompleted ? colors.primaryContainer.withOpacity(0.5) : colors.tertiaryContainer,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
            ),
            child: SizedBox(
              height: width/3.5,
              width: width,
              child: Center(
                child: Text(
                  task.isCompleted ? "COMPLETADO" : "NO COMPLETADO",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tStyle.copyWith(color: Colors.white.withOpacity(task.isCompleted ? 0.5 : 0.9)),
                  textScaleFactor: (2.2*width)/1.sw,
                ),
              ),
            )
          )
        ],
      ),
    );


    // return Card(
      // elevation: 1,
      // margin: EdgeInsets.zero,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // color: Colors.red,
    // );

    // return Card(
    //   clipBehavior: Clip.antiAlias,
    //   elevation: 1,
    //   margin: EdgeInsets.zero,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //   child: SizedBox(
    //     height: height,
    //     width: width,
    //     child: Stack(
    //       children: [
    //         Container(
    //           padding: const EdgeInsets.only(top: 20),
    //           child: Column(
    //             children: [
    //               const Spacer(),
    //               Text(
    //                 task.task,
    //                 style: TextStyle(
    //                   fontSize: 25.spMax,
    //                   fontWeight: FontWeight.w400,
    //                   color: colors.onBackground.withOpacity(0.8)
    //                 ),
    //               ),
    //               const Spacer(),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 20),
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(15),
    //                   child: Container(
    //                     color: colors.surfaceVariant,
    //                     padding: const EdgeInsets.all(15),
    //                     child: Icon(
    //                       task.icon,
    //                       size: height*0.3,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               const Spacer(),
    //               TextButton(
    //                 style: TextButton.styleFrom(
    //                   backgroundColor: task.isCompleted ? colors.primaryContainer : colors.tertiaryContainer,
    //                   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
    //                     bottomLeft: Radius.circular(15),
    //                     bottomRight: Radius.circular(15),
    //                   )),
    //                   elevation: 0,
    //                   padding: EdgeInsets.zero
    //                 ),
    //                 onPressed: onPressed, 
    //                 child: SizedBox(
    //                   height: 60,
    //                   child: Center(child: Text(
    //                     task.isCompleted ? 'COMPLETADO' : 'NO COMPLETADO',
    //                     style: TextStyle(
    //                       color: !task.isCompleted ? colors.secondary : Colors.white,
    //                       fontSize: 18.spMax
    //                     ),
    //                   ))
    //                 )
    //               )
    //             ],
    //           ),
    //         ),

    //         if(task.isCompleted)
    //           GestureDetector(
    //             onTap: onPressed,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(15),
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.black.withOpacity(0.7),
    //                   border: Border.all(
    //                     color: Colors.white.withOpacity(0.7),
    //                     width: 3.spMax
    //                   ),
    //                   borderRadius: const BorderRadius.all(Radius.circular(15))
    //                 ),
    //                 width: 1.sw,
    //                 height: 1.sh,
    //                 child: Icon(
    //                   Icons.check_circle_outline_rounded,
    //                   color: Colors.white.withOpacity(0.7),
    //                   size: 0.5.sw,
              
    //                 ),
    //               ),
    //             ),
    //           )
    //       ],
    //     ),
    //   ),
    // );
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
