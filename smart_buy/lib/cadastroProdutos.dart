import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_buy/database_helper.dart';

class CadastrarProduto extends StatefulWidget {
  final Usuario usuarioLogado;
  const CadastrarProduto({Key? key, required this.usuarioLogado})
      : super(key: key);

  @override
  _CadastrarProdutoState createState() => _CadastrarProdutoState();
}

class _CadastrarProdutoState extends State<CadastrarProduto> {
  final _formKey = GlobalKey<FormState>();
  final _nomeProdutoController = TextEditingController();
  final _descricaoProdutoController = TextEditingController();
  final _precoProdutoController = TextEditingController();
  final _quantidadeProdutoController = TextEditingController();
  File? _imagemProduto;
  List<Categoria> _categorias = [];
  Categoria? _categoriaSelecionada;
  int _usuarioId = 1;

  @override
  void initState() {
    super.initState();
    _carregarCategorias();
  }

  Future<void> _carregarCategorias() async {
    final dbHelper = DatabaseHelper();
    _categorias = await dbHelper.buscarTodasCategorias();
    setState(() {});
  }

  Future<void> _selecionarImagemDaGaleria() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _imagemProduto = File(imagemSelecionada.path);
      });
    }
  }

  Future<void> _tirarFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada =
        await picker.pickImage(source: ImageSource.camera);
    if (imagemSelecionada != null) {
      setState(() {
        _imagemProduto = File(imagemSelecionada.path);
      });
    }
  }

  @override
  void dispose() {
    _nomeProdutoController.dispose();
    _descricaoProdutoController.dispose();
    _precoProdutoController.dispose();
    _quantidadeProdutoController.dispose();
    super.dispose();
  }

  void _limparCampos() {
    _nomeProdutoController.clear();
    _descricaoProdutoController.clear();
    _precoProdutoController.clear();
    _quantidadeProdutoController.clear();
    setState(() {
      _imagemProduto = null;
      _categoriaSelecionada = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE87C17),
        title: Text("Cadastrar Produto"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeProdutoController,
                decoration: InputDecoration(
                  labelText: "Nome do Produto",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do produto';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _descricaoProdutoController,
                decoration: InputDecoration(
                  labelText: "Descrição do Produto",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do produto';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField<Categoria>(
                decoration: InputDecoration(
                  labelText: "Categoria",
                  border: OutlineInputBorder(),
                ),
                value: _categoriaSelecionada,
                items: _categorias.map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria.nome),
                  );
                }).toList(),
                onChanged: (categoria) {
                  setState(() {
                    _categoriaSelecionada = categoria;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione uma categoria';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _precoProdutoController,
                decoration: InputDecoration(
                  labelText: "Preço",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço do produto';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _quantidadeProdutoController,
                decoration: InputDecoration(
                  labelText: "Quantidade",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade do produto';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              _imagemProduto != null
                  ? Image.file(_imagemProduto!, height: 100, width: 100)
                  : Icon(Icons.image, size: 100),
              SizedBox(height: 20.0),
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
                    final produto = Produto(
                      nome: _nomeProdutoController.text,
                      descricao: _descricaoProdutoController.text,
                      imagemProduto:
                          _imagemProduto != null ? _imagemProduto!.path : null,
                      preco: double.parse(_precoProdutoController.text),
                      quantidade: int.parse(_quantidadeProdutoController.text),
                      categoriaId: _categoriaSelecionada!.id!,
                      usuarioId: _usuarioId,
                    );

                    await dbHelper.inserirProduto(produto);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Produto cadastrado com sucesso!')),
                    );

                    _limparCampos();
                  }
                },
                child: Text("Salvar Produto"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
