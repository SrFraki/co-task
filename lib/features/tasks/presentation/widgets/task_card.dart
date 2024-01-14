import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_sharing/config/theme/theme.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    this.isCompleted = false,
    this.task = 'NO TIENES TAREAS',
    required this.onTap
  });

  final bool isCompleted;
  final String task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 3,
            child: Container(
              height: 250,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                task,
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: ATheme.darkMode ? Colors.grey.shade600 : Colors.grey.shade400
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),

          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              splashFactory: NoSplash.splashFactory
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green.shade300 : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isCompleted ? Colors.green.shade300 : ATheme.darkMode ? Colors.white70 :Colors.black,
                  width: 2
                )
              ),
              child: Text(
                isCompleted ? 'COMPLETADO' : 'COMPLETAR',
                style: TextStyle(
                  fontSize: 18,
                  color: isCompleted ? ATheme.darkMode ? Colors.green.shade50 : Colors.green.shade100 : ATheme.darkMode ? Colors.white70 : Colors.black,
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