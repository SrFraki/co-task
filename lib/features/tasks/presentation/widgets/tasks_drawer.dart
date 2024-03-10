import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_sharing/config/theme/theme.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_sharing/features/shared/presentation/widgets/are_you_sure.dart';
import 'package:task_sharing/features/tasks/domain/models/task.dart';
import 'package:task_sharing/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:task_sharing/features/tasks/presentation/widgets/custom_button.dart';
import 'package:task_sharing/features/tasks/presentation/widgets/user_task_info.dart';

class TasksDrawer extends ConsumerWidget {
  const TasksDrawer({
    super.key,
    required this.state,
    required GlobalKey<ScaffoldState> scaffoldkey,
  }) : _scaffoldkey = scaffoldkey;

  final TasksPState state;
  final GlobalKey<ScaffoldState> _scaffoldkey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      elevation: 0,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,0),
              child: Text(
                'ÚLTIMA SEMANA',
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
                    for(Task task in state.lastWeekTasks)
                      UsersTaskInfo(
                        own: state.pos == task.user,
                        name: state.names[task.user],
                        task: task
                      ),
                  ],
                ),
              ),
            ),
            // CustomButton('sancionar', () { }),
            // CustomButton('editar', () {
            //   context.push('/editor');
            //   _scaffoldkey.currentState?.closeDrawer();
              
            // }),
            const Spacer(),
            CustomButton('CERRAR SESIÓN', () {
              areYouSure(
                context,
                (){
                  _scaffoldkey.currentState?.closeDrawer();
                  ref.read(authProvider.notifier).logout();
                }
              );
            }),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
