import 'package:flutter/material.dart';

import '../../../../themes.dart';
import 'drawer_item.dart';

class CustomDrawerWeb extends StatefulWidget {
  final Function(int) onItemSelected;

  const CustomDrawerWeb({super.key, required this.onItemSelected});

  @override
  State<CustomDrawerWeb> createState() => _CustomDrawerWebState();
}

class _CustomDrawerWebState extends State<CustomDrawerWeb> {
  int selectedIndex = 0;

  void _handleTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      color: AppColors.darkBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child:Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'images/grad.jpg',
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'yaghmour',
                    style: const TextStyle(
                      fontFamily: 'Barrio',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),


          DrawerItem.build(
            index: 0,
            icon: Icons.home,
            title: 'Home',
            isSelected: selectedIndex == 0,
            onTap: () => _handleTap(0),
          ),
          DrawerItem.build(
            index: 1,
            icon: Icons.gavel,
            title: 'Issues',
            isSelected: selectedIndex == 1,
            onTap: () => _handleTap(1),
          ),
          DrawerItem.build(
            index: 2,
            icon:  Icons.assignment,
            title: 'Issue Request ',
            isSelected: selectedIndex == 2,
            onTap: () => _handleTap(2),
          ),
        ],
      ),
    );
  }
}