import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_buy/cadastroProdutos.dart';
import 'package:smart_buy/listarCategoria.dart'; // Import the CategoriaListPage
import 'package:smart_buy/database_helper.dart';

class HomePage extends StatefulWidget {
  final Usuario usuarioLogado;

  const HomePage({Key? key, required this.usuarioLogado}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Usuario> _estabelecimentos = [];
  List<Categoria> _categorias = [];
  List<Produto> _produtos = [];

  final List<Widget> _pages = [
    Container(),
    ListarCategoriaPage(), // Change this to CategoriaListPage
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final dbHelper = DatabaseHelper();
    _estabelecimentos = await dbHelper.buscarTodosUsuarios()
      ..removeWhere((usuario) => !usuario.estabelecimento)
      ..sort((a, b) => b.id!.compareTo(a.id!));
    _categorias = await dbHelper.buscarTodasCategorias()
      ..sort((a, b) => b.id!.compareTo(a.id!));
    _produtos = await dbHelper.buscarTodosProdutos()
      ..sort((a, b) => b.id!.compareTo(a.id!));

    _pages[0] = HomePageContent(
      usuarioLogado: widget.usuarioLogado,
      estabelecimentos: _estabelecimentos,
      categorias: _categorias,
      produtos: _produtos,
    );

    _pages[2] = CadastrarProduto(
      usuarioLogado: widget.usuarioLogado,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFE87C17),
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xFFE87C17),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_chart_outlined,
              color: Color(0xFFE87C17),
            ),
            label: 'Categoria',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_basket_rounded,
              color: Color(0xFFE87C17),
            ),
            label: 'Produto',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomePageContent extends StatelessWidget {
  final Usuario usuarioLogado;
  final List<Usuario> estabelecimentos;
  final List<Categoria> categorias;
  final List<Produto> produtos;

  HomePageContent({
    required this.usuarioLogado,
    required this.estabelecimentos,
    required this.categorias,
    required this.produtos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFE87C17),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: usuarioLogado.imagemUsuario != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.file(
                              File(usuarioLogado.imagemUsuario!),
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.person_sharp,
                            size: 50.0,
                            color: Colors.white,
                          ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 7.0),
                        Text(
                          'Bem vindo(a)',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          usuarioLogado.nome,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE87C17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('assets/images/banner.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    "Novos Estabelecimentos",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE87C17),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: estabelecimentos.length,
                itemBuilder: (context, index) {
                  final estabelecimento = estabelecimentos[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? 20.0 : 10.0, top: 10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: estabelecimento.imagemUsuario != null
                                ? null
                                : Colors.grey[400],
                            image: estabelecimento.imagemUsuario != null
                                ? DecorationImage(
                                    image: FileImage(
                                        File(estabelecimento.imagemUsuario!)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          estabelecimento.nome,
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
              child: Row(
                children: [
                  Text(
                    "Categorias",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE87C17),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  final categoria = categorias[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? 20.0 : 10.0, top: 10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: categoria.imagemCategoria != null
                                ? null
                                : Colors.grey[400],
                            image: categoria.imagemCategoria != null
                                ? DecorationImage(
                                    image: FileImage(
                                        File(categoria.imagemCategoria!)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          categoria.nome,
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
              child: Row(
                children: [
                  Text(
                    "Produtos",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE87C17),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  final produto = produtos[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? 20.0 : 10.0, top: 10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: produto.imagemProduto != null
                                ? null
                                : Colors.grey[400],
                            image: produto.imagemProduto != null
                                ? DecorationImage(
                                    image:
                                        FileImage(File(produto.imagemProduto!)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          produto.nome,
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
