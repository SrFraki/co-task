import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_sharing/config/theme/theme.dart';
import 'package:task_sharing/features/tasks/domain/models/task.dart';
import 'package:task_sharing/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:task_sharing/features/tasks/presentation/widgets/custom_button.dart';

// ignore: use_key_in_widget_constructors
class EditorScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(tasksPProvider);
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EDITOR',
          style: TextStyle(
            // color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: (){}, //TODO!! -> Show qr 
            icon: FaIcon(Icons.qr_code_scanner_rounded, color: Colors.grey.shade500),
            iconSize: 32,
          ),

          IconButton(
            onPressed: (){}, //TODO!! -> Save changes 
            icon: FaIcon(Icons.save_outlined, color: Colors.grey.shade500),
            iconSize: 32,
          ),

          const SizedBox(width: 10)
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            
          _NameTextField(), //TODO!!
      
          const SizedBox(height: 10),
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(child: _ListData(list: state.tasks.map((e) => e.task).toList())),
                const SizedBox(width: 20),
                Expanded(child: _ListData(list: state.names.map((e) => e.name.toUpperCase()).toList())),
              ],
            ),
          ),
          const SizedBox(height: 10),
      
          _DropdownMenu(
            size: size,
            items: const ['1 SEMANA', '2 SEMANAS', '3 SEMANAS', '1 MÉS'],
            label: 'DURACIÓN DEL CICLO',
          ),
          
          const SizedBox(height: 20),
          
          _DropdownMenu(
            size: size,
            items: const ['LUNES', 'MARTES', 'MIÉRCOLES', 'JUEVES', 'VIERES', 'SÁBADO', 'DOMINGO'],
            label: 'INICIO DEL CICLO',
          ),
      
          const SizedBox(height: 10),
          const Spacer(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(8),
          //     child: DropdownButtonFormField(
          //       onChanged: (_){}, //TODO!!
          //       value: 1,
          //       style: const TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
          //       items: const [
          //         DropdownMenuItem(value: 1, child: Text('1 semana')),
          //         DropdownMenuItem(value: 2, child: Text('2 semanas')),
          //         DropdownMenuItem(value: 3, child: Text('3 semanas')),
          //         DropdownMenuItem(value: 4, child: Text('1 més')),
          //       ], 
          //       iconSize: 35,
          //       borderRadius: BorderRadius.circular(8),
          //       decoration: InputDecoration(
          //         label: Text(
          //           'Duración del ciclo'.toUpperCase(),
          //           style: TextStyle(fontSize: 18, color: Colors.grey.shade600)
          //         ),
          //         border: InputBorder.none,
          //         filled: true,
          //         fillColor: ATheme.cardColor,
                  
          //       ),
          //     ),
          //   ),
          // ),
          
            
          CustomButton(
            'ELIMINAR', 
            () { },
            backgroundColor: Colors.red.shade300,
            color: Colors.red.shade100,
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}

class _DropdownMenu extends StatelessWidget {
  const _DropdownMenu({
    required this.size,
    required this.items,
    required this.label
  });

  final Size size;
  final List<String> items;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: DropdownMenu(
          dropdownMenuEntries: [
            for((int, String) v in items.indexed)
              DropdownMenuEntry(value: v.$1, label: v.$2),
          ],
          textStyle: const TextStyle(
            fontSize: 18
          ),
          trailingIcon: const FaIcon(FontAwesomeIcons.chevronDown),
          selectedTrailingIcon: const FaIcon(FontAwesomeIcons.chevronUp),
          width: size.width-40,
          label: Text(
            label,
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600)
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            fillColor: ATheme.cardColor,
            filled: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15)
          ),
          menuStyle: MenuStyle(
            backgroundColor: const MaterialStatePropertyAll(Color(0xFF353535)),
            elevation: const MaterialStatePropertyAll(0),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          ),
        ),
      ),
    );
  }
}

class _ListData extends StatelessWidget {
  const _ListData({
    required this.list,
  });

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,5),
          child: Text(
            'USUARIOS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: ATheme.darkMode ? Colors.grey.shade600 : Colors.grey.shade800
            ),
          ),
        ),

        for(String text in list)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ATheme.cardColor,
              boxShadow: ATheme.shadow,
              borderRadius: BorderRadius.circular(8)
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 18),
                ),
                const Spacer(),
                FaIcon(FontAwesomeIcons.gripLines, color: Colors.grey.shade500,)
              ],
            ),
          ),
      ],
    );
  }
}

class _NameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: TextFormField(
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          cursorColor: Colors.grey.shade200,
          cursorWidth: 1.2,
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
          maxLines: 1,
          minLines: 1,
          decoration: InputDecoration(
            label: Text(
              'NOMBRE',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600)
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            filled: true,
            fillColor: ATheme.cardColor,
            border: InputBorder.none,
            isCollapsed: false
          ),
        ),
      ),
    );
  }
}