import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_sharing/features/home/presentation/providers/index_provider.dart';
import 'package:task_sharing/features/taks_data/presentation/screens/task_data_screen.dart';

import '../../../shared/presentation/widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   provider: indexProvider,
      //   onTap: (value) => _controller.animateToPage(
      //     value, 
      //     duration: const Duration(milliseconds: 300), 
      //     curve: Curves.easeInOut,
      //   ),
      //   icons: const [
      //     Icons.checklist_rounded,
      //     Icons.home_rounded,
      //     Icons.check_box_outlined,
      //   ],
      // ),
      //TODO
      body: _HomePageView(controller: _controller,),
    );
  }
}




class _HomePageView extends ConsumerWidget {

  const _HomePageView({
    required PageController controller
  }) : _controller = controller ;

  final PageController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // final index = ref.watch(indexProvider);

    return PageView(
      controller: _controller,
      onPageChanged: (value) => ref.read(indexProvider.notifier).update((_) => value),
      children: const[
        // ListScreen(),
        TaskDataScreen(),
        // SettingsScreen()
      ],
    );
  }

}