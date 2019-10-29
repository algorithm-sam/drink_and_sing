import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

List<DrawerItem> drawerItems = [
  DrawerItem(name: 'About Us', icon: AntIcons.info_outline, id: 0),
  DrawerItem(
      name: 'Follow Us On Facebook', icon: AntIcons.facebook_outline, id: 1),
  DrawerItem(name: 'Contact', icon: AntIcons.phone_outline, id: 2),
  DrawerItem(name: 'Share', icon: AntIcons.share_alt, id: 3),
  // DrawerItem(name: 'Sign Out', icon: Icons.exit_to_app)
];

class DrawerItem {
  String name;
  IconData icon;
  int id;
  DrawerItem({this.name, this.icon, this.id});
}
