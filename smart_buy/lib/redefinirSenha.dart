import 'package:flutter/material.dart';
import 'package:smart_buy/LoginPage.dart';
import 'package:smart_buy/redefinirSenhaDois.dart';

class RedefinirSenha extends StatefulWidget {
  const RedefinirSenha({super.key});

  @override
  State<RedefinirSenha> createState() => _RedefinirSenhaState();
}

class _RedefinirSenhaState extends State<RedefinirSenha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        SizedBox(height: 50),

        Text(
          "Esqueceu sua \nsenha?",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Color(0xFFE87C17)),
        ),

        SizedBox(height: 50),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Informe no campo abaixo o seu e-mail, para \nprosseguir com o passo a passo de \nrecuperação de senha.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
                  labelText: "E-mail",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 55),

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
                      MaterialPageRoute(builder: (context) => LoginPage()),
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
                      MaterialPageRoute(builder: (context) => RedefinirSenhaDois()),
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
