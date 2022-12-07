import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/components/searchBar.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final IconData icon;
  final String? title;
  final TabBar? bottom;
  final double height;

  const MyAppBar({
    Key? key,
    required this.icon,
    this.title,
    this.bottom,
    this.height = kToolbarHeight,
  }) : super(key: key);

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
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(widget.icon),
            iconSize: width * 0.05,
            onPressed: widget.icon == FontAwesomeIcons.bars
                ? () => Scaffold.of(context).openDrawer()
                : () => Navigator.pop(context),
          );
        },
      ),
      title: widget.title!.contains('/')
          ? IconButton(
              icon: Image.asset(
                widget.title!,
              ),
              iconSize: width * 0.08,
              onPressed: () {},
            )
          : Text(
              widget.title!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
      actions: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.magnifyingGlass),
          iconSize: width * 0.04,
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchBar(
                listExample: [
                  'Resultado 2021',
                  'Sisu 2021',
                  'Calendário Acadêmico',
                  'Bolsas',
                  'Enacomp',
                ],
              ),
            );
          },
        ),
      ],
      bottom: widget.bottom,
    );
  }
}
