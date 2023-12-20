import 'package:flutter/material.dart';

class IconsUtil {
  static Icon getIconForCategory(String categoryName) {
    switch (categoryName) {
      case 'Utilities':
        return const Icon(
          Icons.lightbulb,
          color: Colors.white,
          size: 35,
        );
      case 'Transportation':
        return const Icon(
          Icons.directions_car,
          color: Colors.white,
          size: 35,
        );
      case 'Food':
        return const Icon(
          Icons.fastfood,
          color: Colors.white,
          size: 35,
        );
      case 'Others':
        return const Icon(
          Icons.category,
          color: Colors.white,
          size: 35,
        );
      case 'Housing':
        return const Icon(
          Icons.home,
          color: Colors.white,
          size: 35,
        );
      case 'Taxes':
        return const Icon(
          Icons.attach_money,
          color: Colors.white,
          size: 35,
        );
      case 'Repairs':
        return const Icon(
          Icons.build,
          color: Colors.white,
          size: 35,
        );
      case 'Healthcare':
        return const Icon(
          Icons.local_hospital,
          color: Colors.white,
          size: 35,
        );
      case 'Insurance':
        return const Icon(
          Icons.security,
          color: Colors.white,
          size: 35,
        );
      case 'Supplies':
        return const Icon(
          Icons.shopping_basket,
          color: Colors.white,
          size: 35,
        );
      case 'Personal':
        return const Icon(
          Icons.person,
          color: Colors.white,
          size: 35,
        );
      case 'Work':
        return const Icon(
          Icons.work,
          color: Colors.white,
          size: 35,
        );
      default:
        return const Icon(
          Icons.category,
          color: Colors.white,
          size: 35,
        );
    }
  }

  static Color getColorsForCategory(String categoryName) {
    switch (categoryName) {
      case 'Utilities':
        return Colors.yellow;
      case 'Transportation':
        return Colors.blue;
      case 'Food':
        return Colors.green;
      case 'Others':
        return Colors.black;
      case 'Housing':
        return Colors.orange;
      case 'Taxes':
        return Colors.purple;
      case 'Repairs':
        return Colors.brown;
      case 'Healthcare':
        return Colors.red;
      case 'Insurance':
        return Colors.indigo;
      case 'Supplies':
        return Colors.teal;
      case 'Personal':
        return Colors.pink;
      case 'Work':
        return Colors.greenAccent;
      default:
        return Colors.black;
    }
  }
}
