import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:task_sharing/config/theme/theme.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_sharing/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:task_sharing/features/tasks/presentation/widgets/task_card.dart';

import '../widgets/user_task_info.dart';

class TasksScreen extends ConsumerWidget {
   
  const TasksScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TAREAS',
          style: TextStyle(
            // color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => ref.read(authProvider.notifier).logout(),
            icon: const Icon(Icons.logout_rounded),
            iconSize: 27,
          ),
          const SizedBox(width: 5)
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const TasksScreenView(),
    );
  }
}

class TasksScreenView extends ConsumerStatefulWidget {
  const TasksScreenView({
    super.key,
  });

  @override
  ConsumerState<TasksScreenView> createState() => _TasksScreenViewState();
}

class _TasksScreenViewState extends ConsumerState<TasksScreenView> {
  
  int page = 0;
 

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tasksPProvider);
    final notifier = ref.read(tasksPProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 348,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) => setState(() => page = value),
              itemCount: state.ownAreCompleted.length,
              itemBuilder: (context, i) => TaskCard(
                onTap: () => state.ownTasks.first != 'NO TIENES TAREAS' ? notifier.toggleIsCompleted(page) : null,
                isCompleted: state.ownAreCompleted[i],
                task: state.ownTasks[i],
              ),
            ),
          ),
          
          if(state.ownAreCompleted.isNotEmpty)
            PageViewDotIndicator(
              currentItem: page,
              count: state.ownAreCompleted.length,
              unselectedColor: Colors.grey.shade400,
              selectedColor: Colors.green.shade300
            ),
      
          const SizedBox(height: 60),
      
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'REGISTRO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: ATheme.darkMode ? Colors.grey.shade600 : Colors.grey.shade800
              ),
            ),
          ),
      
          const SizedBox(height: 15,),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Column(
              children: [
                for(int i=0; i<state.simplifiedList.length; i++)
                  UsersTaskInfo(
                    name: state.names[state.simplifiedList[i]],
                    task: state.tasks[state.simplifiedList[i]],
                    isCompleted: state.areCompleted[state.simplifiedList[i]],
                  ),
              ],
            ),
          )
      
          // Expanded(
          //   child: ListView.builder(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     physics: const ClampingScrollPhysics(),
          //     itemCount: state.simplifiedList.length,
          //     // itemCount: state.names.length,
          //     itemBuilder: (context, i) => 
          //   ),
          // )
        ],
      ),
    );
  }
}
