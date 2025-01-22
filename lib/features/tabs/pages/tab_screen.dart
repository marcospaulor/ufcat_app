import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/features/tabs/widgets/news_list.dart';
import 'package:ufcat_app/providers/firebase_api.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:ufcat_app/shared/app_bar.dart';

class TabScreen extends StatefulWidget {
  final int index;

  const TabScreen({
    super.key,
    required this.index,
  });

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late Future<List<Map<String, dynamic>>> _futureInfos;

  @override
  void initState() {
    super.initState();
    _futureInfos = _loadDataFromFirebase();
  }

  Future<List<Map<String, dynamic>>> _loadDataFromFirebase() async {
    return FirebaseApi().getData();
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
            _buildNewsList('noticia'),
            _buildNewsList('evento'),
            _buildNewsList('edital'),
          ],
        ),
        bottomNavigationBar: BottomBar(drawerKey: drawerKey),
      ),
    );
  }

  Widget _buildNewsList(String category) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureInfos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: orangeUfcat,));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return NewsList(
            futureInfos: Future.value(snapshot.data),
            category: category,
          );
        }
      },
    );
  }
}
