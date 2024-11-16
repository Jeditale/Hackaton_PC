import 'package:flutter/material.dart';

class HotbarNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  HotbarNavigation({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Adjust height of the hotbar
      decoration: BoxDecoration(
        color: Color(0xFFB6D3F3), // Hotbar background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIcon(Icons.notifications, 0),
          _buildIcon(Icons.air, 1),
          _buildIcon(Icons.home, 2),
          _buildIcon(Icons.shopping_bag, 3),
          _buildIcon(Icons.pie_chart, 4),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index) {
    bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: isSelected ? 58 : 41, // Adjust width for selected/unselected
        height: isSelected ? 55 : 45, // Adjust height for selected/unselected
        decoration: BoxDecoration(
          color: isSelected ? Colors.black.withOpacity(0.1) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          size: isSelected ? 32 : 28, // Adjust icon size for selected/unselected
          color: Colors.black,
        ),
      ),
    );
  }
}
