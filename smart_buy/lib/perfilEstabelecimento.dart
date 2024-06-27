// perfilEstabelecimento.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_buy/database_helper.dart';
import 'package:smart_buy/LoginPage.dart';
import 'package:smart_buy/editarPerfilEstab.dart';

class PerfilEstabelecimento extends StatefulWidget {
  final int estabelecimentoId;

  const PerfilEstabelecimento({Key? key, required this.estabelecimentoId}) : super(key: key);

  @override
  _PerfilEstabelecimentoState createState() => _PerfilEstabelecimentoState();
}

class _PerfilEstabelecimentoState extends State<PerfilEstabelecimento> {
  Usuario? _usuario; // Make the _usuario variable nullable

  @override
   @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
  }

  Future<void> _carregarDadosUsuario() async {
    final dbHelper = DatabaseHelper();
    final usuario = await dbHelper.buscarUsuarioPorId(widget.estabelecimentoId);
    setState(() {
      _usuario = usuario;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE87C17),
        title: Text(
          'Seu Perfil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () async {
              final usuarioAtualizado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditarPerfilEstabelecimento(usuario: _usuario!),
                ),
              );

              if (usuarioAtualizado != null) {
                setState(() {
                  _usuario = usuarioAtualizado;
                });
              }
            },
          ),
        ],
      ),
      body: _usuario == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  _usuario!.imagemUsuario != null
                      ? Image.file(File(_usuario!.imagemUsuario!))
                      : Icon(Icons.image, color: Color(0xFFE87C17), size: 100,),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nome'),
                      Text(
                        _usuario!.nome,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Documento'),
                      Text(
                        _usuario!.documento,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Endereço'),
                      Text(
                        _usuario!.endereco,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Telefone'),
                      Text(
                        _usuario!.telefone,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email'),
                      Text(
                        _usuario!.email,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Senha'),
                      Text(
                        _usuario!.senha,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  if (_usuario!.horaAbertura != null && _usuario!.horaFechamento != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hora de Funcionamento'),
                        Text(
                          '${TimeOfDay.fromDateTime(_usuario!.horaAbertura!).format(context)} - ${TimeOfDay.fromDateTime(_usuario!.horaFechamento!).format(context)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}