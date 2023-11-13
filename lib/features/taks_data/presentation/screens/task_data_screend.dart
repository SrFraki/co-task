import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_sharing/features/taks_data/presentation/providers/task_provider.dart';

class TaskDataScreen extends ConsumerWidget {
  const TaskDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskPProvider);
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              state.task.task,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: colors.onBackground.withOpacity(0.8)
              ),
            ),
    
            Card(
              elevation: 5,
              color: colors.surfaceVariant,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                height: size.width/1.8,
                width: size.width/2.2,
                padding: const EdgeInsets.all(15),
                child: Icon(
                  state.task.icon,
                  size: size.width/3,
                ),
              ),
            ),
    
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: !state.task.isCompleted ? colors.primaryContainer : colors.tertiaryContainer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5
              ),
              onPressed: ref.read(taskPProvider.notifier).toggleComplete, 
              child: SizedBox(
                width: size.width/2.2,
                height: 40,
                child: Center(child: Text(
                  state.task.isCompleted ? 'COMPLETADO' : 'NO COMPLETADO',
                  style: TextStyle(
                    color: !state.task.isCompleted ? colors.primary : Colors.white,
                    fontSize: 18
                  ),
                ))
              )
            )
          ],
        ),
      ),
    );
  }
}