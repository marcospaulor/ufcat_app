import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/features/tabs/widgets/new_list.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ufcat_app/providers/webscrap.dart';

class TabScreen extends StatefulWidget {
  final int index;

  const TabScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late Future<List<Map<String, dynamic>>> _futureInfos;

  @override
  void initState() {
    super.initState();

    _futureInfos = readJson();
  }

  Future<List<Map<String, dynamic>>> readJson() async {
    // Do a webScraping to get the data
    List<dynamic> data = <dynamic>[];
    try {
      final webScraping = WebScraping();
      await webScraping.scrapeData();
    } catch (e) {
      // If the webScraping fails, load the data from the JSON file
      // Load the data from the JSON file
      final String response =
          await rootBundle.loadString('assets/database/data.json');
      data = await json.decode(response);
    }

    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> drawerKey = GlobalKey();

    return DefaultTabController(
      length: 3,
      initialIndex: widget.index,
      child: Scaffold(
        key: drawerKey,
        appBar: const MyAppBar(
          icon: FontAwesomeIcons.arrowLeft,
          title: 'Serviços UFCAT',
          height: 2 * kToolbarHeight,
          bottom: TabBar(
            labelColor: orangeUfcat,
            unselectedLabelColor: grayUfcat,
            indicatorColor: orangeUfcat,
            tabs: [
              Tab(
                icon: Text('NOTÍCIAS'),
              ),
              Tab(
                icon: Text('EVENTOS'),
              ),
              Tab(
                icon: Text('EDITAIS'),
              ),
            ],
          ),
        ),
        endDrawer: const MyNavigationDrawer(),
        body: TabBarView(
          children: [
            NewsList(
              futureInfos: _futureInfos,
              category: 'noticia',
              readJson: readJson,
            ),
            NewsList(
              futureInfos: _futureInfos,
              category: 'evento',
              readJson: readJson,
            ),
            NewsList(
              futureInfos: _futureInfos,
              category: 'edital',
              readJson: readJson,
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(drawerKey: drawerKey),
      ),
    );
  }
}
