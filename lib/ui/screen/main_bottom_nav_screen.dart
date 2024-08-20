import 'package:flutter/material.dart';

import '../utility/app_colors.dart';
import '../widget/profile_app_bar.dart';
import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'in_progress_task_screen.dart';
import 'new_task_screen.dart';




class MainBottomNavigationScreen extends StatefulWidget {
  const MainBottomNavigationScreen({super.key});

  @override
  State<MainBottomNavigationScreen> createState() =>
      _MainBottomNavigationScreenState();
}

class _MainBottomNavigationScreenState
    extends State<MainBottomNavigationScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens =  [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const InProgressTaskScreen(),
    const CancelledTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'New Task'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.refresh), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Cancelled'),
        ],
      ),
    );
  }
}