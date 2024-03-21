// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:smart_buy/home.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({super.key});

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 30.0, right: 30.0, bottom: 20.0),
              // ROW DE VOLTAR
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Text(
                        '< Voltar',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hipermercado C.Vale',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE87C17),
                    ),
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20.0),
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 3.0),
                  child: TextField(
                    decoration: InputDecoration (
                      labelText: "Buscar categoria",
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Icon(
                          Icons.filter_list,
                          color: Color(0xFFE87C17),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row (
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 15.0),
                  child: Text(
                    'Selecione uma categoria',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                    )
                  )
                )
              ],
            ),
            SizedBox(height: 15),
            Row (
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Grãos',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Massas',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Molhos',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Temperos',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
              ],
            ),
            SizedBox(height: 10),
            Row (
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 45.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Limpeza',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Higiene Pessoal',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Carnes',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Bebidas',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
              ],
            ),
            SizedBox(height: 10),
            Row (
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Doces',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Congelados',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 17.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Conservas',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Laticínios',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
              ],
            ),
            SizedBox(height: 10),
            Row (
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 52.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Frutas',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 33.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Verduras',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Legumes',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.0, top: 10.0, right: 30.0),
                  child: Text(
                    'Padaria',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  )
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 10.0, right: 40.0, bottom: 20.0),
                  child: IconButton(
                    icon: Icon (
                      Icons.home,
                      color: Colors.grey[400],
                      size: 40.0,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10.0, right: 30.0),
                  child: Icon (
                    Icons.favorite,
                    color: Color(0xFFE87C17),
                    size: 40.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 27.0, right: 40.0, bottom: 20.0),
                  child: Icon (
                    Icons.shopping_cart,
                    color: Colors.grey[400],
                    size: 40.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 30.0, right: 20.0, bottom: 20.0),
                  child: Icon (
                    Icons.person,
                    color: Colors.grey[400],
                    size: 40.0,
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
