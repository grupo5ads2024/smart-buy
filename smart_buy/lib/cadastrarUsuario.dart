import 'package:flutter/material.dart';

class CadastrarUsuario extends StatefulWidget {
  const CadastrarUsuario({super.key});

  @override
  State<CadastrarUsuario> createState() => _CadastrarUsuarioState();
}

class _CadastrarUsuarioState extends State<CadastrarUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cadastrar usuario'),
      ),
      body: Center(
        child: Text('cadastre-se'),
      ),
    );
  }
}