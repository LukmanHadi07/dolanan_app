// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/core/theme/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Slidedots extends StatelessWidget {
  bool isActive;
  Slidedots({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: isActive ? 12 : 8,
        width: isActive ? 25 : 8,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ));
  }
}
