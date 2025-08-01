import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final String hint;
  final Function(String) onSearch;

  const CustomSearchBar({
    super.key,
    required this.onSearch,
    this.hint = 'Search...',
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _handleSearch(String value) {
    widget.onSearch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(
          colors: [
            Color(0xFFE3F2FD), // أزرق فاتح جدا
            Color(0xFFBBDEFB), // أزرق فاتح
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 6,
            offset: const Offset(0, -2),
            spreadRadius: -4,
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        onChanged: _handleSearch,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF0D47A1),
          fontWeight: FontWeight.w500,
        ),
        cursorColor: Color(0xFF0D47A1),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Colors.blueGrey.shade300,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF0D47A1)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(
              color: Color(0xFF0D47A1),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
