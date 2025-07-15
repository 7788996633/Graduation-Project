import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../constant.dart';
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
      width: 190,
      color: AppColors.darkBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
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
                    tr('Yaghmur'),
                    style: const TextStyle(
                      fontFamily: 'Barrio',
                      color: AppColors.scaffold,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          DrawerItem.build(
            index: 0,
            icon: Icons.home,
            title: tr('home'),
            isSelected: selectedIndex == 0,
            onTap: () => _handleTap(0),
          ),

          DrawerItem.build(
            index: 1,
            icon: Icons.people,
            title: tr('employees'),
            isSelected: selectedIndex == 1,
            onTap: () => _handleTap(1),
          ),

          DrawerItem.build(
            index: 2,
            icon: Icons.vpn_key,
            title: tr('permissions'),
            isSelected: selectedIndex == 2,
            onTap: () => _handleTap(2),
          ),

          DrawerItem.build(
            index: 3,
            icon: Icons.gavel,
            title: tr('issues'),
            isSelected: selectedIndex == 3,
            onTap: () => _handleTap(3),
          ),

          DrawerItem.build(
            index: 4,
            icon: Icons.request_page_outlined,
            title: tr('issue_request'),
            isSelected: selectedIndex == 4,
            onTap: () => _handleTap(4),
          ),

          DrawerItem.build(
            index: 5,
            icon: Icons.beach_access_outlined,
            title: tr('furloughs'),
            isSelected: selectedIndex == 5,
            onTap: () => _handleTap(5),
          ),

          DrawerItem.build(
            index: 6,
            icon: Icons.category_outlined,
            title: tr('session_type'),
            isSelected: selectedIndex == 6,
            onTap: () => _handleTap(6),
          ),

          DrawerItem.build(
            index: 7,
            icon: Icons.assignment_turned_in_outlined,
            title: tr('required_documents'),
            isSelected: selectedIndex == 7,
            onTap: () => _handleTap(7),
          ),

          DrawerItem.build(
            index: 8,
            icon: Icons.forum_outlined,
            title: tr('Consultation_Requests'),
            isSelected: selectedIndex == 8,
            onTap: () => _handleTap(8),
          ),

          DrawerItem.build(
            index: 9,
            icon: Icons.question_answer_rounded,
            title: tr('Common_Consultation'),
            isSelected: selectedIndex == 9,
            onTap: () => _handleTap(9),
          ),

          DrawerItem.build(
            index: 10,
            icon: Icons.question_answer_rounded,
            title: tr('Issue_categories'),
            isSelected: selectedIndex == 10,
            onTap: () => _handleTap(10),
          ),
        ],
      ),
    );
  }
}
