import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_buy/database_helper.dart';

class EditarCategoria extends StatefulWidget {
  final Categoria categoria;

  const EditarCategoria({Key? key, required this.categoria}) : super(key: key);

  @override
  _EditarCategoriaState createState() => _EditarCategoriaState();
}

class _EditarCategoriaState extends State<EditarCategoria> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCategoriaController = TextEditingController();
  final _descricaoCategoriaController = TextEditingController();
  File? _imagemCategoria;

  @override
  void initState() {
    super.initState();
    _nomeCategoriaController.text = widget.categoria.nome;
    _descricaoCategoriaController.text = widget.categoria.descricao;
    if (widget.categoria.imagemCategoria != null) {
      _imagemCategoria = File(widget.categoria.imagemCategoria!);
    }
  }

  Future<void> _selecionarImagemDaGaleria() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _imagemCategoria = File(imagemSelecionada.path);
      });
    }
  }

  Future<void> _tirarFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada =
        await picker.pickImage(source: ImageSource.camera);
    if (imagemSelecionada != null) {
      setState(() {
        _imagemCategoria = File(imagemSelecionada.path);
      });
    }
  }

  @override
  void dispose() {
    _nomeCategoriaController.dispose();
    _descricaoCategoriaController.dispose();
    super.dispose();
  }

  void _limparCampos() {
    _nomeCategoriaController.clear();
    _descricaoCategoriaController.clear();
    setState(() {
      _imagemCategoria = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE87C17),
        title: Text(
          "Editar Categoria",
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
              _imagemCategoria != null
                  ? Image.file(_imagemCategoria!, height: 100, width: 100)
                  : Icon(Icons.image, color: Color(0xFFE87C17), size: 100),
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
                controller: _nomeCategoriaController,
                decoration: InputDecoration(
                  labelText: "Nome da Categoria",
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
                    return 'Por favor, insira o nome da categoria';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _descricaoCategoriaController,
                decoration: InputDecoration(
                  labelText: "Descrição da Categoria",
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
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição da categoria';
                  }
                  return null;
                },
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
                    final dbHelper = DatabaseHelper();
                    final categoriaAtualizada = Categoria(
                      id: widget.categoria.id,
                      nome: _nomeCategoriaController.text,
                      descricao: _descricaoCategoriaController.text,
                      imagemCategoria:
                          _imagemCategoria != null ? _imagemCategoria!.path : null,
                    );

                    await dbHelper.atualizarCategoria(categoriaAtualizada);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Categoria atualizada com sucesso!'),
                      ),
                    );

                    // Atualizar a lista de categorias na tela anterior
                    Navigator.pop(context, true); // Retorna true para indicar atualização
                  }
                },
                child: Text(
                  "Salvar Categoria",
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
}
