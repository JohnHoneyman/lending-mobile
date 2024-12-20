import 'package:flutter/material.dart';

class BotNavbarWidget extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const BotNavbarWidget(
      {super.key, required this.selectedIndex, required this.onTap});

  @override
  State<BotNavbarWidget> createState() => _BotNavbarWidgetState();
}

class _BotNavbarWidgetState extends State<BotNavbarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: widget.onTap,
    );
  }
}
