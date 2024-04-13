import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/searchbar/search_bar.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class BottomBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  const BottomBar({
    super.key,
    required this.drawerKey,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: greenUfcat,
      selectedItemColor: grayUfcat,
      unselectedItemColor: grayUfcat,
      iconSize: 20.0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.magnifyingGlass),
          label: 'Pesquisa',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.bars),
          label: 'Menu',
        ),
      ],
      onTap: (value) {
        switch (value) {
          case 0:
            Navigator.of(context).popUntil((route) => route.isFirst);
            break;
          case 1:
            showSearch(
              context: context,
              delegate: MySearchBar(context: context),
            );
            break;
          case 2:
            widget.drawerKey.currentState!.openEndDrawer();
            break;
        }
      },
    );
  }
}
