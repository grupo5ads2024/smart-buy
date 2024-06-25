import 'package:flutter/material.dart';
import 'package:smart_buy/database_helper.dart';

class HomeConsumidor extends StatelessWidget {
  final Usuario usuarioLogado;

  const HomeConsumidor({required this.usuarioLogado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Consumidor'),
      ),
      body: Center(
        child: Text('Bem-vindo, ${usuarioLogado.nome}!!\nVocê é um consumidor.'),
      ),
    );
  }
}