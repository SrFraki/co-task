import 'package:flutter/material.dart';

class IconConstant{
  static IconData getIcon([String? task]) {
    switch(task){
      case 'COCINA': return Icons.kitchen_outlined;
      case 'PASILLO': return Icons.cleaning_services_rounded;
      case 'COMEDOR': return Icons.dining_outlined;
      case 'COMPRAR': return Icons.shopping_cart_outlined;
      case 'VACACIONES': return Icons.beach_access;
      default: return Icons.phone_in_talk_rounded;
    }
  }
}