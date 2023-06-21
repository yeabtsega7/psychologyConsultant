import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:psychological_consultation/src/model/appColors.dart';
import 'package:psychological_consultation/src/screen/DiscussionsPage.dart';
import 'package:psychological_consultation/src/screen/end_user/HomePage.dart';
import 'package:psychological_consultation/src/screen/PsychologistPage.dart';
import 'package:psychological_consultation/src/screen/end_user/editeAcountPage.dart';

import '../ResourcesPage.dart';

// ignore: camel_case_types
class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

// ignore: camel_case_types
class _bottomNavigationBarState extends State<bottomNavigationBar> {
  final PersistentTabController _controller= PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const DiscussionsPage(),
      const ResourcesPage(),
      const PsychologistPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: appColors.textP,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.people),
        title: ("Discussions"),
        activeColorPrimary: appColors.textP,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.folder ),
        title: ("Resources"),
        activeColorPrimary: appColors.textP,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.psychology),
        title: ("Psychologist"),
        activeColorPrimary: appColors.textP,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.gray,
        actions: [
          IconButton(onPressed: (){
            PersistentNavBarNavigator.pushNewScreen(context, screen: editeAccountPage(),withNavBar: false);
          },
              icon: Icon(Icons.manage_accounts,size: 40,color: appColors.textP,))
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: appColors.gray, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
}
