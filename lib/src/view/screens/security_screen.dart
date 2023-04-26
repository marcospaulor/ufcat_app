import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/components/app_bar.dart';
import 'package:ufcat_app/src/view/components/bottom_bar.dart';
import 'package:ufcat_app/src/view/components/side_menu.dart';
import 'package:ufcat_app/src/view/style/const.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreen();
}

class _SecurityScreen extends State<SecurityScreen> {
  String? dropdownValue;
  LatLng getLocation() {
    return const LatLng(24.003456360119625, 90.34202758271798);
  }

  final _formKey = GlobalKey<FormState>();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  GoogleMapController? mapController;

  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  late LatLng _position;
  bool _permission = false;

  @override
  void initState() {
    _position = const LatLng(-18.154695973733883, -47.928891981710066);
    _handlePermission();
    _getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Acidente de Trânsito',
      'Agressão',
      'Assalto',
      'Assédio',
      'Comportamento suspeito',
      'Furto',
      'Incêndio',
      'Vandalismo',
      'Outros',
    ];

    Map<String, String> contact = {
      'Vigilância UFCAT': '(64) 3441-5391',
      'SAMU': '192',
      'Bombeiros': '193',
      'Polícia Militar': '190',
    };

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: drawerKey,
        appBar: const MyAppBar(
          icon: FontAwesomeIcons.arrowLeft,
          title: 'Segurança',
          height: 2 * kToolbarHeight,
          bottom: TabBar(
            labelColor: orangeUfcat,
            unselectedLabelColor: grayUfcat,
            indicatorColor: orangeUfcat,
            tabs: [
              Tab(
                icon: Text('CHAMADAS E DENÚNCIAS'),
              ),
              Tab(
                icon: Text('EMERGÊNCIA'),
              ),
            ],
          ),
        ),
        drawer: const MyNavigationDrawer(),
        body: Center(
          child: TabBarView(
            children: [
              SingleChildScrollView(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<String>(
                          value: dropdownValue,
                          hint: const Text('Categoria'),
                          validator: (String? value) {
                            if (value == null) {
                              return 'Selecione uma categoria';
                            }
                            return null;
                          },
                          items: categories.map(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value;
                            });
                          },
                          borderRadius: BorderRadius.circular(20.0),
                          style: const TextStyle(
                            color: darkUfcat,
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 15,
                            inputFormatters: [
                              MaskTextInputFormatter(
                                  mask: '(##) #####-####',
                                  type: MaskAutoCompletionType.lazy),
                            ],
                            style: const TextStyle(
                              color: darkUfcat,
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Telefone de contato (com DDD)',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            maxLines: 5,
                            style: const TextStyle(
                              color: darkUfcat,
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Descrição',
                            ),
                          ),
                        ),
                        _permission == true
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 30.0),
                                height: 300,
                                child: GoogleMap(
                                  mapType: MapType.hybrid,
                                  liteModeEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                    target: _position ?? getLocation(),
                                    zoom: 18.25,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId: const MarkerId('marker_1'),
                                      position: _position ?? getLocation(),
                                    ),
                                  },
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    mapController = controller;
                                  },
                                  // Move the camera to the new position
                                  onCameraMove: (CameraPosition position) {
                                    setState(() {
                                      _position = position.target;
                                    });
                                  },
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(bottom: 30.0),
                                padding: const EdgeInsets.all(10.0),
                                height: 300,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: grayUfcat,
                                  border: Border.all(
                                    color: grayUfcat,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Text(
                                  'Não foi possível obter sua localização, habilite a permissão de localização no seu dispositivo.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: darkUfcat,
                                    fontSize: 16,
                                  ),
                                )),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Enviando...'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 40),
                              backgroundColor: orangeUfcat,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text('ENVIAR',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: contact.entries
                    .map(
                      (item) => Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: grayUfcat,
                              width: 1,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse('tel:${item.value}'));
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 0),
                            backgroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: ListTile(
                            title: Text(item.key),
                            subtitle: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                      size: 15,
                                      FontAwesomeIcons.phone,
                                      color: redUfcat),
                                ),
                                Text(
                                  item.value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: darkUfcat.withOpacity(0.75),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(drawerKey: drawerKey),
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();

    setState(() {
      _position = LatLng(position.latitude, position.longitude);
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _position, zoom: 18.25)));
      mapController?.moveCamera(CameraUpdate.newLatLng(_position));
    });
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();

      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) return false;

    setState(() {
      _permission = true;
    });

    return true;
  }
}
