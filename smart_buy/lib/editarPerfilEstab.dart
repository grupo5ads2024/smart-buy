import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database_helper.dart';

class EditarPerfilEstabelecimento extends StatefulWidget {
  final Usuario usuario;

  const EditarPerfilEstabelecimento({Key? key, required this.usuario}) : super(key: key);

  @override
  _EditarPerfilEstabelecimentoState createState() => _EditarPerfilEstabelecimentoState();
}

class _EditarPerfilEstabelecimentoState extends State<EditarPerfilEstabelecimento> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _documentoController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  TimeOfDay? _horaAbertura;
  TimeOfDay? _horaFechamento;
  File? _imagemUsuario;

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.usuario.nome;
    _documentoController.text = widget.usuario.documento;
    _enderecoController.text = widget.usuario.endereco;
    _telefoneController.text = widget.usuario.telefone;
    _emailController.text = widget.usuario.email;
    _senhaController.text = widget.usuario.senha;
    _horaAbertura = _timeOfDayFromDateTime(widget.usuario.horaAbertura ?? DateTime.now());
    _horaFechamento = _timeOfDayFromDateTime(widget.usuario.horaFechamento ?? DateTime.now());
    if (widget.usuario.imagemUsuario != null) {
      _imagemUsuario = File(widget.usuario.imagemUsuario!);
    }
  }

  Future<void> _selecionarImagemDaGaleria() async {
    final picker = ImagePicker();
    final imagemSelecionada = await picker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _imagemUsuario = File(imagemSelecionada.path);
      });
    }
  }

  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final imagemSelecionada = await picker.pickImage(source: ImageSource.camera);
    if (imagemSelecionada != null) {
      setState(() {
        _imagemUsuario = File(imagemSelecionada.path);
      });
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _documentoController.dispose();
    _enderecoController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE87C17),
        title: Text(
          "Editar Perfil",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0),
              _imagemUsuario != null
                  ? Image.file(_imagemUsuario!, height: 100, width: 100)
                  : Icon(Icons.person, color: Color(0xFFE87C17), size: 100),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _selecionarImagemDaGaleria,
                    child: Text(
                      'Galeria',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _tirarFoto,
                    child: Text(
                      'Câmera',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE87C17)),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _documentoController,
                decoration: InputDecoration(
                  labelText: "Documento (CPF/CNPJ)",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE87C17)),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o documento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _enderecoController,
                decoration: InputDecoration(
                  labelText: "Endereço",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE87C17)),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(
                  labelText: "Telefone",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE87C17)),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE87C17)),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o e-mail';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE87C17)),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o e-mail';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: _buildTimePicker(
                      labelText: "Hora de Abertura",
                      initialTime: _horaAbertura!,
                      onTimeChanged: (time) {
                        setState(() {
                          _horaAbertura = time;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTimePicker(
                      labelText: "Hora de Fechamento",
                      initialTime: _horaFechamento!,
                      onTimeChanged: (time) {
                        setState(() {
                          _horaFechamento = time;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE87C17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final usuarioAtualizado = Usuario(
                      id: widget.usuario.id,
                      nome: _nomeController.text,
                      documento: _documentoController.text,
                      endereco: _enderecoController.text,
                      telefone: _telefoneController.text,
                      email: _emailController.text,
                      senha: _senhaController.text,
                      horaAbertura: _convertTimeOfDayToDateTime(_horaAbertura!),
                      horaFechamento: _convertTimeOfDayToDateTime(_horaFechamento!),
                      imagemUsuario: _imagemUsuario != null ? _imagemUsuario!.path : null,
                      estabelecimento: widget.usuario.estabelecimento,
                    );

                    final dbHelper = DatabaseHelper();
                    await dbHelper.atualizarUsuario(usuarioAtualizado);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Perfil atualizado com sucesso!'),
                      ),
                    );

                    Navigator.pop(context, usuarioAtualizado); // Retorna usuário atualizado
                  }
                },
                child: Text(
                  "Salvar Alterações",
                  style: TextStyle(
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

  Widget _buildTimePicker({
    required String labelText,
    required TimeOfDay initialTime,
    required ValueChanged<TimeOfDay> onTimeChanged,
  }) {
    return InkWell(
      onTap: () async {
        TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );
        if (newTime != null) {
          onTimeChanged(newTime);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE87C17)),
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${initialTime.hour}:${initialTime.minute.toString().padLeft(2, '0')}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
      ),
    );
  }

  DateTime _convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  TimeOfDay _timeOfDayFromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }
}