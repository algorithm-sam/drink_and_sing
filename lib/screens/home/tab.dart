import 'package:ant_icons/ant_icons.dart';
import 'package:drinkandsing/constants/fonts.dart';
import 'package:drinkandsing/constants/styles.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatelessWidget {
  final Function doSwitchTab;
  final int selectedIndex;
  BottomTab({Key key, this.selectedIndex, this.doSwitchTab});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(AntIcons.customer_service),
            title: Text(
              'Songs',
            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text(
              'Favorites',
            )),
      ],
      selectedLabelStyle: TextStyle(
        color: Color(0XFF000000),
        fontSize: 14.0,
        fontWeight: FontWeight.w800,
        fontFamily: appbarFont,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.grey,
        fontSize: 13.0,
        fontWeight: FontWeight.w800,
        fontFamily: appbarFont,
      ),
      selectedItemColor: primarylight,
      currentIndex: selectedIndex,
      onTap: doSwitchTab,
    );
  }
}
