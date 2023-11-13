import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onTap,
    this.icons = const[],
    this.index = 2,
    required StateProvider<int> provider
  }) : _provider = provider, assert(icons.length >= 2);

  final void Function(int index) onTap;
  final List<IconData> icons;
  final int index;
  final StateProvider<int> _provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final currentIndex = ref.watch(_provider);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(22),
        topRight: Radius.circular(22),
      ),
      child: Container(
        width: double.infinity,
        height: 70,
        color: colors.surfaceVariant,
        child: Stack(
          alignment: Alignment.center,
          children: [

            AnimatedPositioned(
              left: (width/icons.length)*currentIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: Container(
                width: width/icons.length,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    color: colors.secondary.withOpacity(0.4),
                  ),
                ),
              )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: icons.map((e) => GestureDetector(
                onTap: () {
                  ref.read(_provider.notifier).update((_) => icons.indexOf(e));
                  onTap(icons.indexOf(e));
                },
                child: Container(
                  color: Colors.transparent,
                  width: width/icons.length,
                  height: 50,
                  child: Icon(
                    e,
                    color: colors.background,
                    size: 35,
                  ),
                )
              )).toList()
            )
          ],
        ),
      ),
    );
  }
}
