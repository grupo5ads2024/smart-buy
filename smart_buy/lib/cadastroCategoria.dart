import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_buy/database_helper.dart';

class CadastrarCategoria extends StatefulWidget {
  const CadastrarCategoria({Key? key}) : super(key: key);

  @override
  _CadastrarCategoriaState createState() => _CadastrarCategoriaState();
}

class _CadastrarCategoriaState extends State<CadastrarCategoria> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCategoriaController = TextEditingController();
  final _descricaoCategoriaController = TextEditingController();
  File? _imagemCategoria;

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

  // Função para limpar os campos do formulário
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
        title: Text("Cadastrar Categoria",
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
                  : Icon(Icons.image, color: Color(0xFFE87C17) , size: 100),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _selecionarImagemDaGaleria,
                    child: Text('Galeria',
                      style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _tirarFoto,
                    child: Text('Câmera',
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
                  color: Colors.black, // Cor laranja para o texto da etiqueta
                  ),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0), // Borda arredondada
                  ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE87C17)), // Borda laranja quando ativado
                  borderRadius: BorderRadius.circular(40.0), // Borda arredondada quando ativado
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
                  color: Colors.black, // Cor laranja para o texto da etiqueta
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE87C17)), // Borda laranja quando ativado
                  borderRadius: BorderRadius.circular(40.0), // Borda arredondada quando ativado
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
                    final categoria = Categoria(
                      nome: _nomeCategoriaController.text,
                      descricao: _descricaoCategoriaController.text,
                      imagemCategoria: _imagemCategoria != null
                          ? _imagemCategoria!.path
                          : null,
                    );

                    // Aguarda a inserção da categoria no banco de dados
                    await dbHelper.inserirCategoria(categoria);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Categoria cadastrada com sucesso!')),
                    );

                    // Limpa os campos após salvar
                    _limparCampos();
                  }
                },
                child: Text(
                  "Salvar Categoria",
                  style: TextStyle(
                  color: Colors.white,
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
