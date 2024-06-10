// cadastroUsuario.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_buy/database_helper.dart';

class CadastrarUsuario extends StatefulWidget {
  const CadastrarUsuario({super.key});

  @override
  State<CadastrarUsuario> createState() => _CadastrarUsuarioState();
}

class _CadastrarUsuarioState extends State<CadastrarUsuario> {
  final _formKey = GlobalKey<FormState>();
  bool _isEstabelecimento = false; // Define se o usuário é um estabelecimento
  final _nomeController = TextEditingController();
  final _documentoController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _horaAberturaController = TextEditingController();
  final _horaFechamentoController = TextEditingController();

  TimeOfDay? _horaAbertura;
  TimeOfDay? _horaFechamento;

  File? _imagemUsuario; // Variável para armazenar a imagem do usuário

  Future<void> _selectHoraAbertura(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _horaAbertura ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _horaAbertura) {
      setState(() {
        _horaAbertura = picked;
        _horaAberturaController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectHoraFechamento(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _horaFechamento ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _horaFechamento) {
      setState(() {
        _horaFechamento = picked;
        _horaFechamentoController.text = picked.format(context);
      });
    }
  }

  // Função para abrir a galeria de imagens e selecionar uma imagem
  Future<void> _selecionarImagemDaGaleria() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _imagemUsuario = File(imagemSelecionada.path);
      });
    }
  }

  // Função para abrir a câmera e tirar uma foto
  Future<void> _tirarFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada =
        await picker.pickImage(source: ImageSource.camera);
    if (imagemSelecionada != null) {
      setState(() {
        _imagemUsuario = File(imagemSelecionada.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Botão para escolher tipo de usuário
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEstabelecimento = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isEstabelecimento ? Colors.grey : Color(0xFFE87C17),
                    ),
                    child: Text('Consumidor'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEstabelecimento = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isEstabelecimento ? Color(0xFFE87C17) : Colors.grey,
                    ),
                    child: Text('Estabelecimento'),
                  ),
                ],
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _documentoController,
                decoration: InputDecoration(labelText: 'Documento (CPF/CNPJ)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o documento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _enderecoController,
                decoration: InputDecoration(labelText: 'Endereço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),

              // Campo para a imagem do usuário
              SizedBox(height: 16),
              _imagemUsuario != null
                  ? Image.file(_imagemUsuario!, height: 100, width: 100)
                  : Icon(Icons.person, size: 100),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _selecionarImagemDaGaleria,
                    child: Text('Galeria'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _tirarFoto,
                    child: Text('Câmera'),
                  ),
                ],
              ),

              // Campos para estabelecimentos
              if (_isEstabelecimento) ...[
                SizedBox(height: 16),
                TextFormField(
                  controller: _horaAberturaController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Hora de Abertura',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () => _selectHoraAbertura(context),
                    ),
                  ),
                  onTap: () => _selectHoraAbertura(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione a hora de abertura';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _horaFechamentoController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Hora de Fechamento',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () => _selectHoraFechamento(context),
                    ),
                  ),
                  onTap: () => _selectHoraFechamento(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione a hora de fechamento';
                    }
                    return null;
                  },
                ),
              ],
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final dbHelper = DatabaseHelper();
                    final usuario = Usuario(
                      nome: _nomeController.text,
                      documento: _documentoController.text,
                      endereco: _enderecoController.text,
                      telefone: _telefoneController.text,
                      email: _emailController.text,
                      senha: _senhaController.text,
                      estabelecimento: _isEstabelecimento,
                      horaAbertura: _horaAbertura != null
                          ? DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              _horaAbertura!.hour,
                              _horaAbertura!.minute,
                            )
                          : null,
                      horaFechamento: _horaFechamento != null
                          ? DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              _horaFechamento!.hour,
                              _horaFechamento!.minute,
                            )
                          : null,
                      imagemUsuario:
                          _imagemUsuario != null ? _imagemUsuario!.path : null,
                    );

                    await dbHelper.inserirUsuario(usuario);
                    Navigator.pop(context); // Volta para a tela de login
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
