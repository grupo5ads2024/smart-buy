import 'package:flutter/material.dart';
import 'package:smart_buy/database_helper.dart';
import 'package:smart_buy/cadastroProdutos.dart';
import 'package:smart_buy/editarProduto.dart';

class ListarProdutosPage extends StatefulWidget {
  @override
  _ListarProdutosPageState createState() => _ListarProdutosPageState();
}

class _ListarProdutosPageState extends State<ListarProdutosPage> {
  List<Produto> _produtos = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  void _carregarProdutos() async {
    List<Produto> produtos = await _dbHelper.buscarTodosProdutos();
    setState(() {
      _produtos = produtos;
    });
  }

  void _deleteProduto(int id) async {
    await _dbHelper.deletarProduto(id);
    _carregarProdutos();
  }

  void _editProduto(Produto produto) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarProduto(produto: produto),
      ),
    );

    _carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE87C17),
        title: Text(
          'Produtos',
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
              // Navegar para a tela de cadastro de produtos
              //Navigator.push(
              //  context,
              //  MaterialPageRoute(
              //    builder: (context) => CadastrarProduto(),
              //  ),
              //).then((_) {
                // Recarregar produtos após retornar da página de cadastro
              //  _carregarProdutos();
              //});
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _produtos.length,
        itemBuilder: (context, index) {
          Produto produto = _produtos[index];
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                title: Text(
                  produto.nome,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preço: R\$ ${produto.preco.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Quantidade: ${produto.quantidade}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editProduto(produto),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteProduto(produto.id!),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 1,
                height: 0,
              ),
            ],
          );
        },
      ),
    );
  }
}
