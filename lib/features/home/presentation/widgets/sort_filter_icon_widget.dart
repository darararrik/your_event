import 'package:flutter/material.dart';

class SortFilterIconWidget extends StatelessWidget {
  final Function()? onTap;

  final Widget icon;

  const SortFilterIconWidget({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 52,
          height: 52,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color:
                    Color.fromRGBO(117, 117, 117, 0.1), // Настройте цвет тени
                offset: Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 33,
              ),
            ],
          ),
          child: icon),
    );
  }
}
