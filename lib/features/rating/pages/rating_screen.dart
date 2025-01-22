import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/form/custom_textarea.dart';
import 'package:ufcat_app/shared/star_rating.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/shared/form/dropdown_selector.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class RatingScreen extends StatefulWidget {
  final Map<String, dynamic> dataMeal;
  final int selectedMeal;
  final String currentDay;

  const RatingScreen(
      {super.key,
      required this.dataMeal,
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

  final db = FirebaseFirestore.instance;

  List<String> diasDaSemana = [
    'Segunda-feira',
    'Terca-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];

  @override
  void initState() {
    super.initState();
    assert(widget.currentDay.isNotEmpty);

    if (diasDaSemana.isNotEmpty) {
      String matchingDay = diasDaSemana.firstWhere(
        (day) => day.toUpperCase().startsWith(widget.currentDay.toUpperCase()),
        orElse: () => '',
      );
      if (matchingDay.isNotEmpty) {
        dropDownWeek = matchingDay;
      } else {
        dropDownWeek = diasDaSemana.first;
      }
    } else {
      dropDownWeek = '';
    }

    selected = widget.selectedMeal == 0 ? true : false;
    meal = widget.selectedMeal == 0 ? 'Almoço' : 'Jantar';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
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
                    width: width,
                    height: height * 0.075,
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: grayUfcat,
                        ),
                      ),
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
                    width: width,
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
                      borderWidth: 2,
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
                        // widget para tornar a largura do botão do mesmo tamanho do widget pai
                        SizedBox(
                          width: width * 0.4,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Almoço',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        selected ? Colors.white : Colors.black,
                                  ),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: width * 0.4,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Jantar',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        selected ? Colors.black : Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // dropdown
                  DropdownSelector(
                    label: "Dia da semana",
                    hintText: 'Selecione um dia da semana',
                    items: diasDaSemana,
                    selectedValue: dropDownWeek,
                    onChanged: (String? value) {
                      setState(() {
                        dropDownWeek = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // input area
                  CustomTextArea(
                    label: 'Comentário',
                    maxLength: 100,
                    hintText: 'Digite seu comentário aqui...',
                    controller: controller,
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> data = {
                          'rating': currentRating,
                          'meal': meal,
                          'day': dropDownWeek,
                          'comment': controller.text,
                          'actual_date': DateTime.now().toString(),
                          'dataMeal': widget.dataMeal,
                        };

                        // using firestore
                        await db
                            .collection('ru')
                            .doc('rating')
                            .collection(
                                'avaliacoes') // Subcoleção onde as avaliações serão armazenadas
                            .add(
                                data) // Usando add() para gerar um ID único para cada avaliação
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Avaliação enviada com sucesso!'),
                            ),
                          );
                          Navigator.pop(context);
                        }).catchError((onError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Erro ao enviar avaliação!'),
                            ),
                          );
                        });
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}
