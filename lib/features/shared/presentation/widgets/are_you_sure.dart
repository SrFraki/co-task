import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sharing/config/theme/theme.dart';

Future<void> areYouSure(BuildContext context, void Function() onAccept) async {
  await showAdaptiveDialog(
    context: context, 
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      backgroundColor: ATheme.cardColor,
      elevation: 0,

      title: const Text('¿Estás seguro?'),
      titlePadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
      titleTextStyle: TextStyle(
        color: ATheme.darkMode ? Colors.grey.shade200 : Colors.grey.shade800,
        fontSize: 21,
        letterSpacing: 1.3
      ),
      
      content: const Text('Se cerrará la sesión actual.'),
      contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      contentTextStyle: TextStyle(
        fontSize: 16,
        color: ATheme.darkMode ? Colors.grey.shade400 : Colors.grey.shade600,
        letterSpacing: .8
      ),

      actions: [
        _Button(
          onTap: onAccept,
          text: 'Cerrar sesión',
          color: Colors.red.shade300,
        ),
        const Spacer(),
        _Button(
          onTap: () => context.pop(),
          text: 'Cancelar',
          color: ATheme.green,
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      actionsOverflowButtonSpacing: 0,
    ),
  );
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onTap, required this.text, required this.color,
  });

  final void Function() onTap;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Ink(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: color,
            letterSpacing: .9,
            shadows: const [Shadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0,0)
            )]
          ),
        ),
      ),
    );
  }
}