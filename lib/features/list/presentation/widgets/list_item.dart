import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    this.value = false,
    required this.onChanged,
    this.delete,
    this.onEditingComplete,
    this.onFieldChanged,
    this.initialValue
  });

  final bool? value;
  final void Function(bool?)? onChanged;
  final VoidCallback? delete;
  final void Function(String value)? onEditingComplete;
  final void Function(String value)? onFieldChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {

    String textValue = '';
    
    return Row(
      children: [
        const Icon(
          Icons.drag_indicator_rounded,
          color: Colors.white38,
        ),
    
        Checkbox(
          value: value, 
          onChanged: onChanged
        ),
    
        Expanded(
          child: TextFormField(
            initialValue: initialValue,
            onTapOutside: (_) {
              if(onEditingComplete != null && textValue.isNotEmpty) onEditingComplete!(textValue);
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onChanged: (value) => textValue = value,
            onEditingComplete: () => (onEditingComplete != null && textValue.isNotEmpty) ? onEditingComplete!(textValue) : null,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          )
        ),
    
        GestureDetector(
          onTap: delete,
          child: const Icon(
            Icons.close_rounded,
            color: Colors.white38,
          ),
        )
      ],
    );
  }
}