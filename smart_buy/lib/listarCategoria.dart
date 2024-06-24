import 'package:flutter/material.dart';
import 'package:smart_buy/database_helper.dart';
import 'package:smart_buy/cadastroCategoria.dart';
import 'package:smart_buy/editarCategoria.dart'; // Importe o arquivo da tela de edição

class ListarCategoriaPage extends StatefulWidget {
  @override
  _ListarCategoriaPageState createState() => _ListarCategoriaPageState();
}

class _ListarCategoriaPageState extends State<ListarCategoriaPage> {
  List<Categoria> _categorias = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadCategorias();
  }

  void _loadCategorias() async {
    List<Categoria> categorias = await _dbHelper.buscarTodasCategorias();
    setState(() {
      _categorias = categorias;
    });
  }

  void _deleteCategoria(int id) async {
    await _dbHelper.deletarCategoria(id);
    _loadCategorias();
  }

  void _editCategoria(Categoria categoria) async {
    // Navegar para a tela de edição e aguardar retorno
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarCategoria(categoria: categoria),
      ),
    );

    // Após retornar da tela de edição, recarregar a lista de categorias
    _loadCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE87C17),
        title: Text(
          'Categorias',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 36,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastrarCategoria(),
                ),
              ).then((_) {
                // Recarregar categorias após retornar da página de cadastro
                _loadCategorias();
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _categorias.length,
        itemBuilder: (context, index) {
          Categoria categoria = _categorias[index];
          return Column(
            children: [
              ListTile(
                title: Text(categoria.nome),
                subtitle: Text(categoria.descricao),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editCategoria(categoria), // Chame o método _editCategoria aqui
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteCategoria(categoria.id!),
                    ),
                  ],
                ),
              ),
              Divider( // Adiciona o Divider entre os itens da lista
                color: Colors.grey[400],
                thickness: 1, // Define a espessura da linha
                height: 0, // Define a altura do Divider
              ),
            ],
          );
        },
      ),
    );
  }
}
