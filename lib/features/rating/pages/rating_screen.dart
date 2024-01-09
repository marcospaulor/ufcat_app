import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/star_rating.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final _formKey = GlobalKey<FormState>();
  String? dropDownValue;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    List<String> _refeicao = ['Almoço', 'Jantar'];

    return Scaffold(
      key: drawerKey,
      appBar: const MyAppBar(
        title: 'Avaliação',
        icon: FontAwesomeIcons.arrowLeft,
      ),
      endDrawer: const MyNavigationDrawer(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: height * 1,
            width: double.infinity,
            child: ListView(children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Icon(
                          FontAwesomeIcons.heartCircleCheck,
                          color: greenUfcat,
                          size: 120,
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Text(
                        'Avalie a refeição!',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: primaryBlack),
                      ),
                    ),
                    Container(
                      width: width * 0.8,
                      height: height * 0.075,
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: grayUfcat,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: StarRating(
                        padding: 10.0,
                        size: 30.0,
                      ),
                    ),
                    // dropdown
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: width * 0.8,
                      height: height * 0.075,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: grayUfcat,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            // remove border
                            border: InputBorder.none,
                            // aumentando o tamanho
                            contentPadding: EdgeInsets.all(0),
                          ),
                          value: dropDownValue,
                          hint: const Text('Selecione a refeição'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, selecione uma refeição';
                            }
                            return null;
                          },
                          items: _refeicao.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              dropDownValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                    // input area
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: width * 0.8,
                      child: const TextField(
                        maxLines: 8,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          hintText: 'Digite seu comentário aqui...',
                          filled: true,
                          fillColor: grayUfcat,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          SnackBar snackBar = const SnackBar(
                            content: Text('Avaliação enviada com sucesso!'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * 0.4, height * 0.05),
                          backgroundColor: orangeUfcat,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('ENVIAR'),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}
