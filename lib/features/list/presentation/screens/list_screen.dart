import 'package:flutter/material.dart';
import 'package:task_sharing/features/list/presentation/providers/shop_list_provider.dart';
import 'package:task_sharing/features/list/presentation/widgets/list_container.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(
          child: Column(
            children: [
              ListContainer(title: 'Personal', type: ShopListType.personal,),
              SizedBox(height: 20,),
              ListContainer(title: 'Shared', type: ShopListType.shared,),
            ],
          ),
        ),
      ),
    );
  }
}