// import 'package:attendify/pages/home/screens/home_screen.dart';
// import 'package:flutter/material.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   const CustomBottomNavigationBar({Key? key}) : super(key: key);
//   @override
//   State<CustomBottomNavigationBar> createState() =>
//       _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     // Add navigation based on selected index
//     switch (index) {
//       case 0:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()),
//         );
//         break;
//       case 1:
//         Navigator.pushNamed(context, '/notifications');
//         break;
//       case 2:
//         Navigator.pushNamed(context, '/settings');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60, // Fixed height for bottom bar
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 0,
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.end, // Align items to bottom
//         children: [
//           _buildNavItem(0, Icons.home),
//           _buildNavItem(1, Icons.notifications_none),
//           _buildNavItem(2, Icons.settings),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(int index, IconData icon) {
//     final isSelected = _selectedIndex == index;
//     final color = isSelected ? Colors.orange : Colors.grey;

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: () => _onItemTapped(index),
//         child: Container(
//           padding: const EdgeInsets.only(
//             bottom: 8.0,
//           ), // Added padding at bottom
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.end, // Align to bottom
//             children: [
//               Icon(icon, color: color, size: 28),
//               // Text(label, style: TextStyle(color: color, fontSize: 12)),
//               if (isSelected)
//                 Container(
//                   width: 30,
//                   height: 3,
//                   decoration: BoxDecoration(
//                     color: Colors.orange,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:attendify/pages/home/screens/home_screen.dart';
import 'package:attendify/pages/notification/screens/notification_screen.dart';
import 'package:attendify/utils/constant/app_color.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    NotificationScreen(),
    // Placeholder(), // Settings
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.backgroundColor,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.primaryColor.withOpacity(0.5),
        showSelectedLabels: false, // <-- sembunyikan label
        showUnselectedLabels: false, // <-- sembunyikan label
        type: BottomNavigationBarType.fixed,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '', // tetap wajib ada, tapi bisa dikosongin
          ),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}
