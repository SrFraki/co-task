import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: TextButton(
            onPressed: (){
              ref.read(authProvider.notifier).signInWithGoogle();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Container(
              width: 100,
              height: 100,
              color: colors.secondary.withOpacity(0.1),
              child: const ImageIcon(
                AssetImage('assets/icons/google.png'),
                color: Colors.white,
              ),
            ),
          ),
        )
      ),
    );
  }
}