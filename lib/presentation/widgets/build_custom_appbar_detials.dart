import 'package:flutter/material.dart';
import '../../constant.dart';

PreferredSizeWidget buildCustomAppBar(String title) {
  return AppBar(
    backgroundColor: AppColors.darkBlue,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.white,
      ),
    ),
    centerTitle: true,
    elevation: 4,
  );
}
