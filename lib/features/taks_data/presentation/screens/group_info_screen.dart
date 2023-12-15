import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sharing/features/taks_data/presentation/providers/group_provider.dart';

import '../../domain/models/task.dart';

class GroupInfoScreen extends ConsumerStatefulWidget {
   
  const GroupInfoScreen({Key? key}) : super(key: key);
  
  @override
  ConsumerState<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends ConsumerState<GroupInfoScreen> {

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 4), 
      (timer) async => await ref.read(groupPProvider.notifier).init()
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final List<(String, Task)> g = ref.watch(groupPProvider).tasks;

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: g.length,
        itemBuilder: (context, index) => _GroupItemInfo(
          task: g[index].$2,
          name: g[index].$1,
        ),
      ),
    );
  }
}

class _GroupItemInfo extends StatelessWidget {

  final Task task;
  final String name;

  const _GroupItemInfo({
    required this.task, 
    required this.name
  });

  @override
  Widget build(BuildContext context) {

    final cl = Theme.of(context).colorScheme;
    const tStyle = TextStyle(
      fontSize: 18,
      overflow: TextOverflow.ellipsis,
    );

    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        height: 60,
        width: double.infinity,
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: (1.sw-170)/2),
              child: Text(
                name,
                style: tStyle,
                maxLines: 1,
                
              ),
            ),
            const Icon(
              Icons.arrow_right_rounded,
              size: 40,
              color: Colors.white54,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: (1.sw-170)/2),
              child: Text(
                task.task,
                style: tStyle,
                maxLines: 1,
                
              ),
            ),
            const Spacer(),
            Container(
              width: 60,
              height: double.infinity,
              color: task.isCompleted ? cl.primary.withOpacity(0.3) : cl.error.withOpacity(0.3),
              alignment: Alignment.center,
              child: Icon(
                task.isCompleted ? Icons.check : Icons.close_rounded
              )
            )
          ],
        ),
      ),
    );
  }
}