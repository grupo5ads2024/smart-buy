import 'package:flutter/material.dart';
import 'package:smart_buy/cadastroEstabelecimentos.dart';
import 'package:smart_buy/categoriaPage.dart';
import 'package:smart_buy/estabelecimentos.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xFFE87C17),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
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
                        Text(
                          'Olá Camile,',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE87C17),
                          ),
                        ),
                        SizedBox(height: 7.0),
                        Text(
                          'Encontre tudo que você precisa, em um só lugar!',
                          style: TextStyle(fontSize: 12.0),
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
                  color: Colors.grey[400],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    "Favoritos >",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 20.0 : 10.0),
                    child: Container(
                      height: 80.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(
                        Icons.star,
                        color: Color(0xFFE87C17),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
              child: Row(
                children: [
                  Text(
                    "Navegue por estabelecimento >",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 20.0 : 10.0),
                    child: Container(
                      height: 80.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(
                        Icons.star,
                        color: Color(0xFFE87C17),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
              Icons.favorite,
              color: Colors.grey[400],
            ),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.grey[400],
            ),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
              color: Colors.grey[400],
            ),
            label: 'Estabelecimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_business_outlined,
              color: Colors.grey[400],
            ),
            label: 'Cadastro de Estabelecimentos',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CategoriaPage()),
              );
              break;
            case 2:
              // carrinho
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => estabelecimentos()),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => cadastroEstabelecimento()),
              );
              break;
          }
        },
      ),
    );
  }
}
