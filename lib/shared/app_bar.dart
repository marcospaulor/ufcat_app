import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/searchbar/search_bar.dart';
import 'package:ufcat_app/shared/popup_menu.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final IconData? icon;
  final String? title;
  final TabBar? bottom;
  final double height;
  final bool? isSearch;

  const MyAppBar({
    super.key,
    this.icon,
    this.title,
    this.bottom,
    this.height = kToolbarHeight,
    this.isSearch,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AppBar(
      centerTitle: widget.icon == null ? false : true,
      automaticallyImplyLeading: false,
      leading: widget.icon != null
          ? Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(widget.icon),
                  iconSize: width * 0.05,
                  onPressed: widget.icon == FontAwesomeIcons.bars
                      ? () => Scaffold.of(context).openDrawer()
                      : () => Navigator.pop(context),
                );
              },
            )
          : null,
      title: widget.title!.contains('/')
          ? Image.asset(
              widget.title!,
              width: width * 0.175,
            )
          : Text(
              widget.title!,
              style: const TextStyle(
                fontSize: 22,
                fontFamily: 'WorkSans-Regular',
              ),
            ),
      actions: [
        widget.isSearch == true
            ? IconButton(
                icon: const Icon(FontAwesomeIcons.magnifyingGlass),
                iconSize: width * 0.04,
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MySearchBar(context: context),
                  );
                },
              )
            : Container(),
        const PopupMenu(),
      ],
      // IconButton(
      //         icon: const Icon(FontAwesomeIcons.ellipsisVertical),
      //         onPressed: () {})
      bottom: widget.bottom,
    );
  }
}
