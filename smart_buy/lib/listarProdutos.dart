import 'package:flutter/material.dart';
import 'package:smart_buy/database_helper.dart';
import 'package:smart_buy/cadastroProdutos.dart';
import 'package:smart_buy/editarProduto.dart';

class ListarProdutosPage extends StatefulWidget {
  final Usuario usuarioLogado;
  const ListarProdutosPage({Key? key, required this.usuarioLogado}) : super(key: key);

  @override
  _ListarProdutosPageState createState() => _ListarProdutosPageState();
}

class _ListarProdutosPageState extends State<ListarProdutosPage> {
  List<Produto> _produtos = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadProdutos();
  }

  void _loadProdutos() async {
    List<Produto> produtos = await _dbHelper.buscarTodosProdutos();
    setState(() {
      _produtos = produtos;
    });
  }

  void _deleteProduto(int id) async {
    await _dbHelper.deletarProduto(id);
    _loadProdutos();
  }

  void _editProduto(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarProduto(produto: produto, usuarioLogado: widget.usuarioLogado),
      ),
    ).then((_) {
      // Recarregar produtos após retornar da página de edição
      _loadProdutos();
    });
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
              // Implementar a navegação para a tela de cadastro de produtos
              // Substitua CadastrarProduto() pela sua classe de cadastro de produtos
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastrarProduto(usuarioLogado: widget.usuarioLogado),
                ),
              ).then((_) {
                // Recarregar produtos após retornar da página de cadastro
                _loadProdutos();
              });
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
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                leading: produto.imagemProduto != null
                    ? Image.network(
                        produto.imagemProduto!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.image, size: 70),
                title: Text(
                  produto.nome,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Fonte maior para o nome
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.descricao,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12, // Descrição em itálico
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('Quantidade: ${produto.quantidade}'),
                    Text('Valor: R\$ ${produto.preco.toStringAsFixed(2)}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editProduto(produto), // Chame o método _editProduto aqui
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteProduto(produto.id!),
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