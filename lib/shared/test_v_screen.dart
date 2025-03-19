import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ufcat_app/theme/src/app_colors.dart'; // Certifique-se de ajustar o caminho conforme seu projeto

class TestVersionScreen extends StatelessWidget {
  const TestVersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grayUfcat, // Usa a cor de fundo do tema do seu app
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ícone de aviso
              Icon(
                Icons.lock_outline,
                size: 100,
                color: greenUfcat, // Usa a cor primária do seu tema
              ),
              const SizedBox(height: 20),
              // Título
              const Text(
                "Aplicativo Indisponível",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              // Mensagem explicativa
              const Text(
                "A versão atual do aplicativo está bloqueada ou o período de teste foi encerrado. Entre em contato com o suporte para mais informações.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Botão para fechar o app
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenUfcat, // Cor do botão
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => exit(0), // Fecha o aplicativo
                child: const Text(
                  "Fechar Aplicativo",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}