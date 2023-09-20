import 'package:flutter/material.dart';

class MealListItemTrait extends StatelessWidget {
  final IconData iconData;
  final String label;

  const MealListItemTrait(
      {super.key, required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 18,
          color: Colors.white,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
