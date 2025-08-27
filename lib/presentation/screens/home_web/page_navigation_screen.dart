import 'package:flutter/material.dart';
import '../../../themes.dart';

class NavigationPagesRow extends StatelessWidget {
  final List<String> pages;
  final int selectedIndex;
  final Function(int) onPageSelected;
  final Color scaffoldColor;
  final Color textAndIconColor;

  const NavigationPagesRow({
    super.key,
    required this.pages,
    required this.selectedIndex,
    required this.onPageSelected,
    required this.scaffoldColor,
    required this.textAndIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(pages.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onPageSelected(index),
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 25,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.darkBlue.withOpacity(0.8)
                    : scaffoldColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.darkBlue),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                pages[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : textAndIconColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
