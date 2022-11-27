import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/components/appBar.dart';
import 'package:photo_view/photo_view.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: 'Mapa',
      ),
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
    );
  }
}
