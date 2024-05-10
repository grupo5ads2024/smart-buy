import 'package:flutter/material.dart';
import 'package:smart_buy/home.dart';

class CategoriaPage extends StatelessWidget {
  const CategoriaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hipermercado C.Vale',
            style: TextStyle(color: Color(0xFFE87C17))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[400]),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Buscar categoria",
                suffixIcon: Icon(Icons.filter_list, color: Color(0xFFE87C17)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Selecione uma categoria',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: List.generate(
                8,
                (index) => CategoryCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
