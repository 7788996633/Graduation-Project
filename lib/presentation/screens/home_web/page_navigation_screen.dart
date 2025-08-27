import 'package:flutter/material.dart';
import '../../../themes.dart';

class NavigationPagesRow extends StatelessWidget {
  final List<String> pages;
  final int selectedIndex;
  final Function(int) onPageSelected;
  final Color scaffoldColor;

  const NavigationPagesRow({
    super.key,
    required this.pages,
    required this.selectedIndex,
    required this.onPageSelected,
    required this.scaffoldColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(pages.length, (index) {
          final isSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Material(
              color: isSelected ? AppColors.darkBlue.withOpacity(0.8) : scaffoldColor,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                splashColor: AppColors.darkBlue.withOpacity(0.3),
                onTap: () => onPageSelected(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 25,
                  ),
                  child: Text(
                    pages[index],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey, // اللون الرمادي للنص
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
