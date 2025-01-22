import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/form/custom_textarea.dart';
import 'package:ufcat_app/shared/form/custom_textfield.dart';
import 'package:ufcat_app/shared/form/dropdown_selector.dart';
import 'package:ufcat_app/constants/api_endpoints.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:ufcat_app/data/categories.dart';
import 'package:ufcat_app/data/places.dart';
import 'package:ufcat_app/data/service_type.dart';
import 'package:ufcat_app/shared/form/image_picker.dart';

class OSScreen extends StatefulWidget {
  const OSScreen({super.key});

  @override
  State<OSScreen> createState() => _OSScreenState();
}

class _OSScreenState extends State<OSScreen> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? dropdownValueUnities;
  String? dropdownValuePlaces;
  String? dropdownValueServices;
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController roomTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();
  // final TextEditingController observationTextController =
  //     TextEditingController();
  File? selectedImage;

  void clearForm() {
    setState(() {
      emailTextController.clear();
      nameTextController.clear();
      phoneTextController.clear();
      roomTextController.clear();
      descriptionTextController.clear();
      // observationTextController.clear();
      dropdownValueUnities = null;
      dropdownValuePlaces = null;
      dropdownValueServices = null;
      selectedImage = null;
    });
  }

  void submitForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios!')),
      );
      return;
    }

    const String apiUrl = ApiEndpoints.createOrder;

    // Prepare os dados para envio
    final Map<String, dynamic> requestData = {
      "requested_by": nameTextController.text,
      "dept_name": dropdownValueUnities,
      "phone": phoneTextController.text,
      "category": dropdownValueServices,
      "location": "${dropdownValuePlaces ?? ''} - ${roomTextController.text}",
      "title": "Ordem de Serviço - ${dropdownValueServices ?? ''}",
      "report_description": descriptionTextController.text,
    };

    try {
      // Enviar requisição POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestData),
      );

      debugPrint(response as String?);

      // Verificar se o widget ainda está montado antes de usar o contexto
      if (!mounted) return;

      if (response.statusCode != 201) {
        final errorResponse = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Erro: ${errorResponse["error"] ?? "Desconhecido"}')),
        );
        return;
      }
      clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ordem de serviço criada com sucesso!')),
      );
    } catch (error) {
      // Verificar se o widget ainda está montado antes de usar o contexto
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao enviar o formulário!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: drawerKey,
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: 'O.S. (Ordem de Serviço)',
      ),
      endDrawer: const MyNavigationDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Formulário de Abertura de Ordem de Serviço',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: primaryBlack),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailTextController,
                    label: 'E-mail',
                    isRequired: true,
                    isEmail: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: nameTextController,
                    label: 'Nome',
                    isRequired: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: phoneTextController,
                    isRequired: true,
                    label: 'Telefone de contato',
                    hintText: '(##) #####-####',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '(##) #####-####',
                        type: MaskAutoCompletionType.lazy,
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  DropdownSelector(
                    label: 'Unidade/Orgão de origem',
                    hintText: 'Escolha uma unidade ou orgão de origem',
                    isRequired: true,
                    items: categories,
                    selectedValue: dropdownValueUnities,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValueUnities = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Local do serviço a ser prestado',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: primaryBlack),
                  ),
                  const SizedBox(height: 20),
                  DropdownSelector(
                    label: 'Local do serviço - Bloco',
                    hintText: 'Selecione o bloco do serviço',
                    isRequired: true,
                    items: places,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValuePlaces = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: roomTextController,
                    label: 'Local do Serviço - Sala',
                    isRequired: true,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Escolha o tipo de serviço',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: primaryBlack),
                  ),
                  const SizedBox(height: 20),
                  DropdownSelector(
                    label: 'Manutenção Predial',
                    hintText: 'Selecione o bloco do serviço',
                    isRequired: true,
                    items: service,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValueServices = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextArea(
                    controller: descriptionTextController,
                    label: 'Descrição detalha do serviço',
                    isRequired: true,
                    maxLength: 300,
                    hintText: 'Escreva a descrição detalhada do serviço.',
                  ),
                  // const SizedBox(height: 20),
                  // CustomTextArea(
                  //   controller: observationTextController,
                  //   label: 'Observação',
                  //   maxLength: 300,
                  //   hintText: 'Escreva aqui a sua observação.',
                  // ),
                  const SizedBox(height: 20),
                  ImagePickerInput(
                    onImageSelected: (File? image) {
                      setState(() {
                        selectedImage = image;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: clearForm,
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * 0.4, height * 0.05),
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Limpar'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: submitForm,
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * 0.4, height * 0.05),
                          backgroundColor: orangeUfcat,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Enviar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}
