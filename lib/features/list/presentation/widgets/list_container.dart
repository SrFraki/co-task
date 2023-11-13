import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderables/reorderables.dart';
import 'package:task_sharing/features/list/presentation/providers/shop_list_provider.dart';
import 'package:task_sharing/features/list/presentation/widgets/list_item.dart';

class ListContainer extends ConsumerWidget {
  const ListContainer({
    super.key,
    required this.title,
    required this.type
  });

  final String title;
  final ShopListType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    const tStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white60
    );

    final state = ref.watch(shopListProvider(type));
    ref.read(shopListProvider(type).notifier).load();

    const duration = Duration(milliseconds: 200);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      color: colors.secondaryContainer,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Container(
        // duration: duration,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        width: double.infinity,
        // height: list.displayList ? list.items.length*48+30+16+58 : 58,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: tStyle,
                ),
                GestureDetector(
                  onTap: ref.read(shopListProvider(type).notifier).toggleDisplayList, 
                  child: Icon(
                    !state.displayList ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,
                    size: 42,
                  ),
                )
              ],
            ),

            AnimatedContainer(
              duration: duration,
              height: state.displayList ? 16 : 0,
              child: state.displayList
                ? const Divider(thickness: 1,)
                : const SizedBox(),
            ),

            if(state.displayList)
              AnimatedContainer(
                duration: duration,
                height: state.items.length*48,
                child: ReorderableColumn(
                  onReorder: (oldI, newI) => ref.read(shopListProvider(type).notifier).reorder(oldI, newI),
                  children: [
                    for(int i=0; i<state.items.length; i++)
                      ListItem(
                        key: Key('$i'),
                        onChanged: (_){},
                        value: state.items[i].selected,
                        onEditingComplete: (value) => ref.read(shopListProvider(type).notifier).update(i, data: value),
                        // onFieldChanged: (value) => ref.read(shopListProvider(type).notifier).updateCurrentField(value),
                        delete: () => ref.read(shopListProvider(type).notifier).delete(i),
                        initialValue: state.items[i].data,
                      )
                  ],
                ),
              ),

            AnimatedContainer(
              duration: duration,
              height: state.displayList ? 30 : 0,
              child: state.displayList
                ? _AddListItem(
                  add: () {
                    ref.read(shopListProvider(type).notifier).add();
                  },
                )
                : const SizedBox(),
            )
              

          ],
        ),
      )
    );
  }
}


class _AddListItem extends StatelessWidget {
  const _AddListItem({
    required this.add
  });

  final VoidCallback add;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: add,
      child: const Row(
        children: [
          SizedBox(width: 32.5,),
          Icon(
            Icons.add_rounded,
            color: Colors.white38,
            size: 30,
          ),
          SizedBox(width: 10,),
          Text(
            'Elemento de lista',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18
            ),
          )
        ],
      ),
    );
  }
}