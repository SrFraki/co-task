import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: TextButton.icon(
          onPressed: () => ref.read(authProvider.notifier).signInWithGoogle(), 
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: Colors.black,
            size: 25,
          ),
          label: const Text(
            'Sign In',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.fromLTRB(15,10,20,10),
            elevation: 3
          ),
        ),
      ),
    );
  }
}