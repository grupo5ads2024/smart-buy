import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_buy/database_helper.dart';

class EditarProduto extends StatefulWidget {
  final Produto produto;
  final Usuario usuarioLogado;
  EditarProduto({required this.produto, required this.usuarioLogado});

  @override
  _EditarProdutoState createState() => _EditarProdutoState();
}

class _EditarProdutoState extends State<EditarProduto> {
  final _formKey = GlobalKey<FormState>();
  final _nomeProdutoController = TextEditingController();
  final _descricaoProdutoController = TextEditingController();
  final _precoProdutoController = TextEditingController();
  final _quantidadeProdutoController = TextEditingController();
  File? _imagemProduto;

  @override
  void initState() {
    super.initState();
    _nomeProdutoController.text = widget.produto.nome;
    _descricaoProdutoController.text = widget.produto.descricao;
    _precoProdutoController.text = widget.produto.preco.toString();
    _quantidadeProdutoController.text = widget.produto.quantidade.toString();
    if (widget.produto.imagemProduto != null) {
      _imagemProduto = File(widget.produto.imagemProduto!);
    }
  }

  Future<void> _selecionarImagemDaGaleria() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada = await picker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _imagemProduto = File(imagemSelecionada.path);
      });
    }
  }

  Future<void> _tirarFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada = await picker.pickImage(source: ImageSource.camera);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE87C17),
        title: Text(
          "Editar Produto",
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
              _imagemProduto != null
                  ? Image.file(_imagemProduto!, height: 100, width: 100)
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
                controller: _nomeProdutoController,
                decoration: InputDecoration(
                  labelText: "Nome do Produto",
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
                    return 'Por favor, insira a descrição do produto';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _precoProdutoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço do Produto",
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
                    return 'Por favor, insira o preço do produto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um valor válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _quantidadeProdutoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Quantidade do Produto",
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
                    return 'Por favor, insira a quantidade do produto';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um valor válido';
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
                    final produtoAtualizado = Produto(
                      id: widget.produto.id,
                      nome: _nomeProdutoController.text,
                      descricao: _descricaoProdutoController.text,
                      preco: double.parse(_precoProdutoController.text),
                      quantidade: int.parse(_quantidadeProdutoController.text),
                      imagemProduto: _imagemProduto != null ? _imagemProduto!.path : null,
                      categoriaId: widget.produto.categoriaId,
                      usuarioId: widget.produto.usuarioId,
                    );

                    await dbHelper.atualizarProduto(produtoAtualizado);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Produto atualizado com sucesso!'),
                      ),
                    );

                    // Atualizar a lista de produtos na tela anterior
                    Navigator.pop(context, true); // Retorna true para indicar atualização
                  }
                },
                child: Text(
                  "Salvar Produto",
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
