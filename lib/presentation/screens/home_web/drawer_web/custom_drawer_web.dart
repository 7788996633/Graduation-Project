import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
    final drawerItems = [
      {'icon': Icons.home, 'title': tr('home')},
      {'icon': Icons.gavel, 'title': tr('issues')},
      {'icon': Icons.archive, 'title': tr('archived_issues')},
      {'icon': Icons.group, 'title': tr('delegations')},
      {'icon': Icons.request_page_outlined, 'title': tr('issue_request')},
      {'icon': Icons.beach_access_outlined, 'title': tr('furloughs')},
      {'icon': Icons.assignment_turned_in_outlined, 'title': tr('required_documents')},
      {'icon': Icons.forum_outlined, 'title': tr('consultation_requests')},
      {'icon': Icons.question_answer_rounded, 'title': tr('common_consultation')},
      {'icon': Icons.report, 'title': tr('report')},
      {'icon': Icons.smart_toy, 'title': tr('ai_chat')},
      {'icon': Icons.money, 'title': tr('expenses')},
      {'icon': Icons.newspaper, 'title': tr('legal_books')},
      {'icon': Icons.newspaper, 'title': tr('legal_news')},
      {'icon': Icons.feedback, 'title': tr('complaints')},
    ];

    return Container(
      width: 190,
      color: AppColors.darkBlue,
      child: ListView(
        padding: EdgeInsets.zero,
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
                    tr('username'), // هنا استبدلت الاسم النصي بمفتاح للترجمة
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
          ...List.generate(
            drawerItems.length,
                (index) => DrawerItem.build(
              index: index,
              icon: drawerItems[index]['icon'] as IconData,
              title: drawerItems[index]['title'] as String,
              isSelected: selectedIndex == index,
              onTap: () => _handleTap(index),
            ),
          ),
        ],
      ),
    );
  }
}
