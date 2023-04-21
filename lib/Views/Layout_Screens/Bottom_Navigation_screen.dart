import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/Views/Layout_Screens/Fittness_Screen.dart';
import 'package:medical_app/Views/Layout_Screens/Pharma_Screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'Doctor_Screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {

  final controller = PersistentTabController(initialIndex: 0);
  _buildScreen(){
    return [
      const DoctorScreen(),
      const SafeArea(child: FitnessScreen()),
      PharmaPage(),
      const SafeArea(child: Text('SettingScreen')),
    ];
  }
  _navbarItems()
  {
    return [
    PersistentBottomNavBarItem(icon: const Icon(FontAwesomeIcons.userDoctor),
        title: 'Doctor',inactiveColorPrimary: Colors.grey.shade400,
      activeColorPrimary: Colors.blue
    ),
    PersistentBottomNavBarItem(icon: const Icon(FontAwesomeIcons.personRunning),
        title: 'Fitness',inactiveColorPrimary: Colors.grey.shade400,
        activeColorPrimary: Colors.green
    ),
    PersistentBottomNavBarItem(icon: const Icon(FontAwesomeIcons.pills),
        title: 'Pharma',inactiveColorPrimary: Colors.grey.shade400,
        activeColorPrimary: Colors.orange
    ),
    PersistentBottomNavBarItem(icon: const Icon(FontAwesomeIcons.gear),
        title: 'Settings',inactiveColorPrimary: Colors.grey.shade400,
        activeColorPrimary: Colors.black54
    ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: controller,
        screens: _buildScreen(),
        items: _navbarItems(),
        navBarStyle: NavBarStyle.style1,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(12)
        ),


    );
  }
}
