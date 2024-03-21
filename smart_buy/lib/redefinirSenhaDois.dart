import 'package:flutter/material.dart';
import 'package:smart_buy/LoginPage.dart';
import 'package:smart_buy/redefinirSenha.dart';
import 'package:smart_buy/redefinirSenha3.dart';

class RedefinirSenhaDois extends StatefulWidget {
  const RedefinirSenhaDois({super.key});

  @override
  State<RedefinirSenhaDois> createState() => _RedefinirSenhaDois();
}

class _RedefinirSenhaDois extends State<RedefinirSenhaDois> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        SizedBox(height: 50),

        Text(
          "Enviamos um código \nde segurança",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 33,
              color: Color(0xFFE87C17)),
        ),

        SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verifique o e-mail informado e digite abaixo \no código de segurança.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                  ),
                  labelText: "Código de Segurança",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 50),

        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150.0,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()), // Mudar aqui para a próxima página.
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              
              Container(
                width: 150.0,
                height: 40.0,
                margin: EdgeInsets.only(left: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RedefinirSenha3()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE87C17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Próximo',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ]),
    );
  }
}
