import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/star_rating.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class RatingScreen extends StatefulWidget {
  final Map<String, dynamic>? dataRefeicao;
  final int selectedMeal;
  final String currentDay;

  const RatingScreen(
      {super.key,
      required this.dataRefeicao,
      required this.selectedMeal,
      required this.currentDay});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  late bool selected;
  String? meal;
  late String? dropDownWeek;
  int? currentRating = 3;
  late TextEditingController controller = TextEditingController();

  List<String> diasDaSemana = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];

  @override
  void initState() {
    super.initState();
    selected = widget.selectedMeal == 0 ? true : false;
    meal = widget.selectedMeal == 0 ? 'Almoço' : 'Jantar';
    assert(diasDaSemana.any((day) => day.startsWith(widget.currentDay)));
    String matchingDay =
        diasDaSemana.firstWhere((day) => day.startsWith(widget.currentDay));
    dropDownWeek = matchingDay;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: drawerKey,
      appBar: const MyAppBar(
        title: 'Avaliação',
        icon: FontAwesomeIcons.arrowLeft,
      ),
      endDrawer: const MyNavigationDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
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
                // rating bar
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
                    allowRating: true,
                    onRatingChanged: (rating) {
                      setState(() {
                        currentRating = rating;
                      });
                    },
                  ),
                ),
                // toggle buttons
                Container(
                  width: width * 0.8,
                  height: height * 0.075,
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: ToggleButtons(
                    isSelected: [
                      selected,
                      !selected,
                    ],
                    direction: Axis.horizontal,
                    borderRadius: BorderRadius.circular(30),
                    fillColor: orangeUfcat, // Cor de fundo quando selecionado
                    selectedColor:
                        Colors.white, // Cor do texto quando selecionado
                    onPressed: (int index) {
                      setState(() {
                        selected = !selected;
                      });
                      if (widget.selectedMeal == 0) {
                        meal = 'Almoço';
                      } else {
                        meal = 'Jantar';
                      }
                    },
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.14),
                        child: Text(
                          'Almoço',
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.14),
                        child: Text(
                          'Jantar',
                          style: TextStyle(
                            color: selected ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ],
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
                      value: dropDownWeek,
                      hint: const Text('Selecione um dia da semana'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione um dia da semana';
                        }
                        return null;
                      },
                      items: diasDaSemana.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          dropDownWeek = value;
                        });
                      },
                    ),
                  ),
                ),
                // input area
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: width * 0.8,
                  child: TextField(
                    controller: controller,
                    maxLines: 8,
                    decoration: const InputDecoration(
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
                      print(currentRating);
                      print(meal);
                      print(dropDownWeek);
                      print(controller.text);
                      SnackBar snackBar = const SnackBar(
                        content: Text('Avaliação enviada com sucesso!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}
