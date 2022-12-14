import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/components/app_bar.dart';
import 'package:ufcat_app/src/view/style/const.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreen();
}

class _SecurityScreen extends State<SecurityScreen> {
  String? dropdownValue;

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

    return Scaffold(
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: 'Segurança',
      ),
      body: Center(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: dropdownValue,
                hint: const Text('Categoria'),
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
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  style: TextStyle(
                    color: darkUfcat,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Telefone de Contato (com DDD)',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: TextField(
                  maxLines: 5,
                  style: TextStyle(
                    color: darkUfcat,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Descrição',
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
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
    );
  }
}
