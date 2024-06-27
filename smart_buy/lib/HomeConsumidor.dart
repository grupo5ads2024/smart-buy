import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_buy/database_helper.dart';
import 'package:smart_buy/perfilConsumidor.dart';

class HomeConsumidor extends StatefulWidget {
  final Usuario usuarioLogado;

  const HomeConsumidor({Key? key, required this.usuarioLogado}) : super(key: key);

  @override
  _HomeConsumidorState createState() => _HomeConsumidorState();
}

class _HomeConsumidorState extends State<HomeConsumidor> {
  int _selectedIndex = 0;
  List<Usuario> _estabelecimentos = [];
  List<Widget> _pages = [];

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

    setState(() {
      _pages = [
        HomeConsumidorContent(
          usuarioLogado: widget.usuarioLogado,
          estabelecimentos: _estabelecimentos,
        ),
        PerfilConsumidor(consumidorId: widget.usuarioLogado.id!),
      ];
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.isNotEmpty ? _pages[_selectedIndex] : Center(child: CircularProgressIndicator()),
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
              Icons.person,
              color: Color(0xFFE87C17),
            ),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class HomeConsumidorContent extends StatelessWidget {
  final Usuario usuarioLogado;
  final List<Usuario> estabelecimentos;

  HomeConsumidorContent({
    required this.usuarioLogado,
    required this.estabelecimentos,
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
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xFFE87C17),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: usuarioLogado.imagemUsuario != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
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
                          'Olá, seja bem-vindo(a)',
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
                    "Estabelecimentos",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE87C17),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: estabelecimentos.length,
              itemBuilder: (context, index) {
                final estabelecimento = estabelecimentos[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          estabelecimento.nome,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          estabelecimento.endereco,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Horário: ${TimeOfDay.fromDateTime(estabelecimento.horaAbertura!).format(context)} - ${TimeOfDay.fromDateTime(estabelecimento.horaFechamento!).format(context)}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          estabelecimento.telefone,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
