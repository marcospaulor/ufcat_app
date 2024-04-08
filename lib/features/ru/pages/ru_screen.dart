import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/features/ru/widgets/day_selector.dart';
import 'package:ufcat_app/features/ru/widgets/meal_tab.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RUScreen extends StatefulWidget {
  const RUScreen({Key? key}) : super(key: key);

  @override
  State<RUScreen> createState() => _RUScreenState();
}

class _RUScreenState extends State<RUScreen> {
  late Future<Map<String, dynamic>> _cardapio;
  String _day = 'Segunda';
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _cardapio = readJson();
  }

  Future<Map<String, dynamic>> readJson() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('ru').doc('menu').get();
    Map<String, dynamic> data = querySnapshot.data()!;
    return data;
  }

  @override
  Widget build(BuildContext context) {
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
            FutureBuilder<Map<String, dynamic>>(
              future: _cardapio,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar dados'));
                } else {
                  return TabBarView(
                    children: [
                      // Tab Almoço
                      MealTab(
                        menu: snapshot.data!,
                        day: _day,
                        mealType: 'almoco',
                      ),
                      // Tab Jantar
                      MealTab(
                        menu: snapshot.data!,
                        day: _day,
                        mealType: 'janta',
                      ),
                    ],
                  );
                }
              },
            ),
            DaySelector(
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
