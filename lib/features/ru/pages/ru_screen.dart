import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/features/ru/widgets/day_selector.dart';
import 'package:ufcat_app/features/ru/widgets/meal_tab.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'dart:convert';

class RUScreen extends StatefulWidget {
  const RUScreen({Key? key}) : super(key: key);

  @override
  State<RUScreen> createState() => _RUScreenState();
}

class _RUScreenState extends State<RUScreen> {
  late Future<Map<String, dynamic>> _cardapio;
  String _day = 'Segunda';
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _cardapio = readJson();
    print(_cardapio);
  }

  Future<Map<String, dynamic>> readJson() async {
    Map<String, dynamic> data = <String, dynamic>{};

    // Load the data from the JSON file
    String response = await DefaultAssetBundle.of(context)
        .loadString('assets/database/ruData.json');
    data = await json.decode(response);

    return Map<String, dynamic>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: drawerKey,
        appBar: const MyAppBar(
          icon: FontAwesomeIcons.arrowLeft,
          height: 2 * kToolbarHeight,
          title: 'R.U.',
          bottom: TabBar(
            labelColor: orangeUfcat,
            unselectedLabelColor: grayUfcat,
            indicatorColor: orangeUfcat,
            tabs: [
              Tab(
                text: 'ALMOÇO',
              ),
              Tab(
                text: 'JANTAR',
              ),
            ],
          ),
        ),
        endDrawer: const MyNavigationDrawer(),
        body: Stack(
          children: [
            TabBarView(
              children: [
                // Tab Almoço
                MealTab(
                  menu: _cardapio,
                  day: _day,
                  mealType: 'almoco',
                ),
                // Tab Jantar
                MealTab(
                  menu: _cardapio,
                  day: _day,
                  mealType: 'jantar',
                ),
              ],
            ),
            DaySelector(
              cardapio: _cardapio,
              day: _day,
              height: height,
              onDaySelected: (day) {
                setState(() {
                  _day = day;
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(drawerKey: drawerKey),
      ),
    );
  }
}
