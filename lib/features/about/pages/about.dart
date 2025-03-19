import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir links do GitHub

class About extends StatelessWidget {
  const About({super.key});

  // Função para abrir URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final drawerKey = GlobalKey<ScaffoldState>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: drawerKey,
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: 'Sobre',
      ),
      endDrawer: const MyNavigationDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600), // Limita a largura máxima
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
                      // Ícone ou logotipo no topo
                      Icon(
                        FontAwesomeIcons.graduationCap, // Exemplo de ícone relacionado à universidade
                        size: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 20),
                      // Título
                      Text(
                        'Sobre o Aplicativo',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      // Descrição do aplicativo
                      Text(
                        'Este aplicativo foi desenvolvido para a Universidade Federal de Catalão (UFCAT) em conjunto com o SETI (Secretaria de Tecnologia e Informação).',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 18,
                              color: Colors.grey[800],
                            ),
                      ),
                      const SizedBox(height: 24),
                      // Divisor
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                        indent: screenWidth * 0.1,
                        endIndent: screenWidth * 0.1,
                      ),
                      const SizedBox(height: 24),
                      // Créditos aos desenvolvedores
                      Text(
                        'Desenvolvido por:',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      _buildDeveloperLink(
                        context,
                        'Marcos Paulo Rodrigues',
                        '@marcospaulor',
                        'https://github.com/marcospaulor',
                      ),
                      const SizedBox(height: 8),
                      _buildDeveloperLink(
                        context,
                        'Marcio Filho',
                        '@Marcio-F',
                        'https://github.com/Marcio-F',
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

  // Widget auxiliar para criar links clicáveis para os desenvolvedores
  Widget _buildDeveloperLink(
      BuildContext context, String name, String username, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                color: Colors.grey[800],
              ),
          children: [
            TextSpan(text: '$name '),
            TextSpan(
              text: '($username)',
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}