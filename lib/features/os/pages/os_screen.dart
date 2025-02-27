import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ufcat_app/constants/api_endpoints.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/form/custom_textarea.dart';
import 'package:ufcat_app/shared/form/custom_textfield.dart';
import 'package:ufcat_app/shared/form/dropdown_selector.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:ufcat_app/data/places.dart';
// import 'package:ufcat_app/shared/form/image_picker.dart';

class OSScreen extends StatefulWidget {
  const OSScreen({super.key});

  @override
  State<OSScreen> createState() => _OSScreenState();
}

class _OSScreenState extends State<OSScreen> {
  // Chaves e controladores do formulário
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController roomTextController = TextEditingController();
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();

  // Variáveis dos dropdowns (armazenam os objetos completos)
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> departments = [];

  // Variáveis para exibição e armazenamento dos IDs selecionados
  int? selectedCategoryId;
  String? selectedCategoryName;
  int? selectedDeptId;
  String? selectedDeptName;

  // Para o dropdown de locais (bloco), mantemos como String
  String? dropdownValuePlaces;

  // Imagem selecionada
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  /// Carrega os dados dos dropdowns (categorias e departamentos)
  void _loadDropdownData() {
    fetchCategories();
    fetchDepartments();
  }

  /// Obtém as categorias da API e atualiza o estado
  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(ApiEndpoints.getCategories));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          // Armazena os dados completos (id e name, entre outros, se houver)
          categories = data.cast<Map<String, dynamic>>();
        });
      } else {
        debugPrint('Erro ao buscar categorias: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Erro ao buscar categorias: $error');
    }
  }

  /// Obtém os departamentos da API e atualiza o estado
  Future<void> fetchDepartments() async {
    try {
      final response = await http.get(Uri.parse(ApiEndpoints.getDepts));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          // Armazena os dados completos (id e name)
          departments = data.cast<Map<String, dynamic>>();
        });
      } else {
        debugPrint('Erro ao buscar departamentos: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Erro ao buscar departamentos: $error');
    }
  }

  /// Limpa o formulário, reiniciando todos os campos
  void clearForm() {
    setState(() {
      emailTextController.clear();
      nameTextController.clear();
      phoneTextController.clear();
      roomTextController.clear();
      titleTextController.clear();
      descriptionTextController.clear();
      selectedDeptId = null;
      selectedDeptName = null;
      selectedCategoryId = null;
      selectedCategoryName = null;
      dropdownValuePlaces = null;
      // selectedImage = null;
    });
  }

  /// Executa a submissão do formulário, dividindo as responsabilidades em funções
  Future<void> submitForm() async {
    if (!isFormValid()) {
      showSnackBar('Preencha todos os campos obrigatórios!');
      return;
    }

    final requestData = prepareRequestData();
    final response =
        await sendPostRequest(ApiEndpoints.createOrder, requestData);

    if (!mounted) return;
    handleResponse(response);
  }

  /// Valida o formulário
  bool isFormValid() {
    return _formKey.currentState?.validate() ?? false;
  }

  /// Exibe uma mensagem na tela
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Converte imagem em uma String Base64
  // String? getBase64Image(File? image) {
  //   final bytes = image!.readAsBytesSync();
  //   final base64Image = base64Encode(bytes);

  //   // Detecta o tipo de imagem com base na extensão do arquivo.
  //   String mimeType = 'image/jpeg'; // default
  //   final path = image.path.toLowerCase();
  //   if (path.endsWith('.png')) {
  //     mimeType = 'image/png';
  //   } else if (path.endsWith('.gif')) {
  //     mimeType = 'image/gif';
  //   } else if (path.endsWith('.bmp')) {
  //     mimeType = 'image/bmp';
  //   }
  //   return 'data:$mimeType;base64,$base64Image';
  // }

  /// Prepara os dados do formulário para envio
  Map<String, dynamic> prepareRequestData() {
    return {
      "requested_by": nameTextController.text,
      // Envia o ID, e não o nome
      "dept_name": selectedDeptId,
      'email': emailTextController.text,
      "phone": phoneTextController.text,
      // Envia o ID da categoria
      "category": selectedCategoryId,
      "location": "${dropdownValuePlaces ?? ''} - ${roomTextController.text}",
      "title": titleTextController.text,
      "report_description": descriptionTextController.text,
      // "image": selectedImage != null ? getBase64Image(selectedImage) : null,
    };
  }

  /// Envia a requisição POST para a API
  Future<http.Response?> sendPostRequest(
      String url, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );
      return response;
    } catch (error) {
      if (mounted) showSnackBar('Erro ao enviar o formulário! Erro: $error');
      return null;
    }
  }

  /// Trata a resposta da API
  void handleResponse(http.Response? response) {
    if (response == null) return;

    if (response.statusCode == 201) {
      clearForm();
      showSnackBar('Ordem de serviço criada com sucesso!');
    } else {
      try {
        // Verifica se a resposta contém JSON antes de tentar decodificar
        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          final errorResponse = json.decode(response.body);
          debugPrint('Erro ao enviar o formulário: ${errorResponse["error"]}');
          debugPrint('Resposta: ${response.body}');
          debugPrint('Status: ${response.statusCode}');
          showSnackBar('Erro: ${errorResponse["error"] ?? "Desconhecido"}');
        } else {
          throw FormatException("Resposta não é JSON válida");
        }
      } catch (e) {
        debugPrint('Erro ao decodificar JSON: ${response.statusCode}');
        debugPrint('Resposta: ${response.body}');
        showSnackBar('Erro ao enviar o formulário. Verifique os logs.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Extrai somente os nomes para exibição nos dropdowns
    final List<String> departmentNames =
        departments.map((dept) => dept['name'].toString()).toList();
    final List<String> categoryNames =
        categories.map((cat) => cat['name'].toString()).toList();

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
                  // Dropdown para Departamentos (Unidade/Orgão de origem)
                  DropdownSelector(
                    label: 'Unidade/Orgão de origem',
                    hintText: 'Escolha uma unidade ou orgão de origem',
                    isRequired: true,
                    items: departmentNames,
                    selectedValue: selectedDeptName,
                    onChanged: (String? value) {
                      setState(() {
                        selectedDeptName = value;
                        // Procura o departamento selecionado para obter seu ID
                        final dept = departments.firstWhere(
                          (element) => element['name'] == value,
                          orElse: () => {},
                        );
                        selectedDeptId = dept['id'];
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Dropdown para seleção do local (bloco) – usa a lista 'places' importada
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
                    selectedValue: dropdownValuePlaces,
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
                  // Dropdown para Categorias (Tipo de serviço)
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
                    hintText: 'Selecione o tipo de serviço',
                    isRequired: true,
                    items: categoryNames,
                    selectedValue: selectedCategoryName,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategoryName = value;
                        // Procura a categoria selecionada para obter seu ID
                        final cat = categories.firstWhere(
                          (element) => element['name'] == value,
                          orElse: () => {},
                        );
                        selectedCategoryId = cat['id'];
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Input title
                  CustomTextField(
                    controller: titleTextController,
                    label: 'Título do serviço',
                    isRequired: true,
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
                  // // Seletor de imagem para envio
                  // ImagePickerInput(
                  //   onImageSelected: (File? image) {
                  //     setState(() {
                  //       selectedImage = image;
                  //     });
                  //   },
                  // ),
                  const SizedBox(height: 20),
                  // Botões para limpar ou enviar o formulário
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
