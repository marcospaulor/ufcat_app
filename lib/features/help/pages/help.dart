import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir o email

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final drawerKey = GlobalKey<ScaffoldState>();

  // Função para abrir o cliente de email
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Ajuda com o Aplicativo UFCAT'},
    );
    if (!await launchUrl(emailUri)) {
      throw 'Could not launch $emailUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: drawerKey,
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: 'Ajuda', // Corrigido de 'Sobre' para 'Ajuda'
      ),
      endDrawer: const MyNavigationDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600), // Limita a largura máxima
              child: Card(
                elevation: 4.0, // Adiciona sombra
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Evita expansão desnecessária
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Ícone no topo
                      Icon(
                        FontAwesomeIcons.questionCircle, // Ícone relacionado a ajuda
                        size: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 20),
                      // Título
                      Text(
                        'Precisa de Ajuda?',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      // Mensagem de suporte
                      Text(
                        'Estamos aqui para ajudar! Entre em contato conosco pelo email:',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 18,
                              color: Colors.grey[800],
                            ),
                      ),
                      const SizedBox(height: 12),
                      // Email interativo
                      GestureDetector(
                        onTap: () => _launchEmail('silva.marcos@discente.ufcat.edu.br'),
                        child: Text(
                          'silva.marcos@discente.ufcat.edu.br',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontSize: 18,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Dica adicional (opcional)
                      Text(
                        'Responda com detalhes sobre sua dúvida para um suporte mais rápido!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}