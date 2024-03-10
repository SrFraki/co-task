import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_sharing/config/theme/theme.dart';
import 'package:task_sharing/features/tasks/domain/models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap
  });

  final Task task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 250,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: task.finalized ? ATheme.green : ATheme.cardColor,
                boxShadow: ATheme.shadow
              ),
              child: Text(
                task.task,
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: ATheme.darkMode ? (Colors.green.shade50) : (task.finalized ? Colors.green.shade50 : Colors.grey.shade400)
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),

          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: task.finalized ? ATheme.green : /*Colors.transparent*/ATheme.cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: task.finalized ? ATheme.green : ATheme.darkMode ? Colors.white24 :Colors.black,
                  width: 2
                ),
                boxShadow: ATheme.shadow
              ),
              child: Text(
                task.finalized ? 'COMPLETADO' : 'COMPLETAR',
                style: TextStyle(
                  fontSize: 18,
                  color: task.finalized ? (Colors.green.shade50) : (ATheme.darkMode ? Colors.white70 : Colors.black),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}