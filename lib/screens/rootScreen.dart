import 'package:blogapp/screens/addBlogScreen.dart';
import 'package:blogapp/screens/homeScreen.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/widgets/searchWidget.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  List<Widget> screens = const [
    HomeScreen(),
    SearchWidget(),
    AddBlogScreen(),
  ];

  int selectedIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kwhiteColor,
        
          
          items: const[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,size: 40,),
              label: 'home',
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,size: 40,),
              label: 'search'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,size: 45,color: kBlackColor,),
              label: 'add'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none,size: 40,),
              label: 'notifications'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined,size: 40,),
              label: 'profile',
              
            ),
            
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: onTabTapped
        ),
      ),
    );
  }
}