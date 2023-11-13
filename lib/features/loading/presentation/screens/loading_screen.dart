import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
    const LoadingScreen({super.key});
  
    @override
    Widget build(BuildContext context) {

      final colors = Theme.of(context).colorScheme;
      final size = MediaQuery.of(context).size;

      return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: colors.secondary, 
          size: size.width*0.3
        ),
      );
    }
  }