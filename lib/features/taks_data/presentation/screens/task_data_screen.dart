import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:task_sharing/features/taks_data/presentation/providers/task_provider.dart';

import '../../domain/models/task.dart';

class TaskDataScreen extends ConsumerStatefulWidget {
  final PageController _pageController;

  const TaskDataScreen({
    super.key,
    required PageController pageController
  }) : _pageController = pageController;

  @override
  ConsumerState<TaskDataScreen> createState() => _TaskDataScreenState();
}

class _TaskDataScreenState extends ConsumerState<TaskDataScreen> {

  final _animationDuration = const Duration(milliseconds: 750);
  double _pos = 0;
  late Timer _timer;
  bool _shouldFlip = false;


  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_animationDuration, (timer) { 
      _shouldFlip = !_shouldFlip;
      setState(() {
        _pos = _shouldFlip ? 10 : 0;
      });
    });
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(taskPProvider);
    int n = state.tasks.length;

    return SafeArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
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

          AnimatedPositioned(
            duration: _animationDuration,
            bottom: _pos,
            child: IconButton(
              onPressed: () => widget._pageController.animateToPage(
                1, 
                duration: const Duration(milliseconds: 300), 
                curve: Curves.easeInOut
              ), 
              icon: const Icon(Icons.keyboard_double_arrow_down_rounded),
              color: Colors.white24,
              iconSize: 75,
              splashColor: Colors.transparent,
            ),
          )
        ],
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
  }
}