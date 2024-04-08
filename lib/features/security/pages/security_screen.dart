import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/form/custom_textarea.dart';
import 'package:ufcat_app/shared/form/custom_textfield.dart';
import 'package:ufcat_app/shared/form/dropdown_selector.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  String? dropdownValue;
  LatLng _position = const LatLng(-18.154695973733883, -47.928891981710066);
  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController textAreaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GoogleMapController? mapController;
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  bool _permission = false;

  @override
  void initState() {
    super.initState();
    _handlePermission();
    _getCurrentPosition();
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
              Tab(icon: Text('CHAMADAS E DENÚNCIAS')),
              Tab(icon: Text('EMERGÊNCIA')),
            ],
          ),
        ),
        endDrawer: const MyNavigationDrawer(),
        body: Center(
          child: TabBarView(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DropdownSelector(
                          label: 'Categoria',
                          hintText: 'Escolha uma categoria',
                          items: categories,
                          selectedValue: dropdownValue,
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: inputTextController,
                          label: 'Telefone de contato',
                          hintText: '(##) #####-####',
                          isPassword: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            MaskTextInputFormatter(
                              mask: '(##) #####-####',
                              type: MaskAutoCompletionType.lazy,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomTextArea(
                          controller: textAreaController,
                          maxLength: 100,
                          label: 'Descrição da ocorrência',
                          hintText: 'Digite sua descrição da ocorrência aqui...',
                        ),
                        const SizedBox(height: 20),
                        _permission == true
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 30.0),
                                height: MediaQuery.of(context).size.height * 0.44,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: grayUfcat,
                                  border: Border.all(color: grayUfcat, width: 1),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: GoogleMap(
                                    mapType: MapType.hybrid,
                                    liteModeEnabled: true,
                                    initialCameraPosition: CameraPosition(
                                      target: _position,
                                      zoom: 18.25,
                                    ),
                                    markers: {
                                      Marker(
                                        markerId: const MarkerId('marker_1'),
                                        position: _position,
                                      ),
                                    },
                                    onMapCreated: (GoogleMapController controller) {
                                      mapController = controller;
                                    },
                                    onCameraMove: (CameraPosition position) {
                                      setState(() {
                                        _position = position.target;
                                      });
                                    },
                                  ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(bottom: 30.0),
                                padding: const EdgeInsets.all(10.0),
                                height: 300,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: grayUfcat,
                                  border: Border.all(color: grayUfcat, width: 1),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Text(
                                  'Não foi possível obter sua localização, habilite a permissão de localização no seu dispositivo.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: darkUfcat, fontSize: 16),
                                ),
                              ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Enviando...')),
                                );
                                _saveDataToFirestore();
                                inputTextController.clear();
                                textAreaController.clear();
                                setState(() {
                                  dropdownValue = null;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Preencha todos os campos')),
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
                            child: const Text('ENVIAR', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                    children: contact.entries
                        .map(
                          (item) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: grayUfcat, width: 1)),
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
                                      child: Icon(FontAwesomeIcons.phone, size: 15, color: redUfcat),
                                    ),
                                    Text(
                                      item.value,
                                      style: TextStyle(fontSize: 14, color: darkUfcat.withOpacity(0.75)),
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
      mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _position, zoom: 18.25)));
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

  Future<void> _saveDataToFirestore() async {
    Map<String, dynamic> data = {
      'category': dropdownValue,
      'contact': inputTextController.text,
      'description': textAreaController.text,
      'latitude': _position.latitude,
      'longitude': _position.longitude,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('security').add(data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dados enviados com sucesso!'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao enviar dados!'),
        ),
      );
    }
  }
}
