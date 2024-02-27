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

    // final size = MediaQuery.of(context).size;
    
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 348,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            onPageChanged: (value) => setState(() => page = value),
            itemCount: state.ownTasks.length,
            itemBuilder: (context, i) => TaskCard(
              onTap: () => notifier.toggleIsCompleted(page),
              task: state.ownTasks[i],
            ),
          ),
        ),
        
        if(state.ownTasks.isNotEmpty)
          PageViewDotIndicator(
            currentItem: page,
            count: state.ownTasks.length,
            unselectedColor: Colors.grey.shade400,
            selectedColor: Colors.green.shade300
          ),
    
        // const SizedBox(height: 60),
        const Spacer(),
    
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                for(int i=0; i<state.tasks.length; i++)
                  UsersTaskInfo(
                    name: state.names[i],
                    task: state.tasks[i]
                  ),
              ],
            ),
          ),
        ),
    
        const Spacer(),
      ],
    );
  }
}
