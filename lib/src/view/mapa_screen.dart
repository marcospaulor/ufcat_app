import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/components/app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:ufcat_app/src/view/components/bottom_bar.dart';
import 'package:ufcat_app/src/view/side_menu.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: drawerKey,
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: 'Mapa',
      ),
      drawer: const NavigationDrawer(),
      body: Center(
        child: PhotoView(
          enablePanAlways: true,
          minScale: PhotoViewComputedScale.contained,
          imageProvider: const AssetImage(
            'assets/images/mapa.png',
          ),
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}
