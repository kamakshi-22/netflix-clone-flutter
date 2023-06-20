import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/screens/screens.dart';
import 'package:flutter_netflix_clone/widgets/responsive.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = const [
    HomeScreen(
      key: PageStorageKey('homeScreen'),
    ),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Search': Icons.search,
    'Coming Soon': Icons.queue_play_next,
    'Downloads': Icons.file_download,
    'More': Icons.menu,
  };

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? BottomNavigationBar(
                backgroundColor: Colors.black,
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
                type: BottomNavigationBarType
                    .fixed, //no animation when switching tabs
                selectedItemColor: Colors.white,
                selectedFontSize: 11.0,
                unselectedItemColor: Colors.grey,
                unselectedFontSize: 11.0,
                items: _icons
                    .map(
                      (key, value) => MapEntry(
                        key,
                        BottomNavigationBarItem(
                          icon: Icon(
                            value,
                            size: 30.0,
                          ),
                          label: key,
                        ),
                      ),
                    )
                    .values
                    .toList(),
              )
            : null);
  }
}
