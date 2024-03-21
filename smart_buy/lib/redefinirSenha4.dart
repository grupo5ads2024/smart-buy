import 'package:flutter/material.dart';
import 'package:smart_buy/LoginPage.dart';

class RedefinirSenha4 extends StatefulWidget {
  const RedefinirSenha4({super.key});

  @override
  State<RedefinirSenha4> createState() => _RedefinirSenha4State();
}

class _RedefinirSenha4State extends State<RedefinirSenha4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/verificado.png', // Substitua pelo caminho correto da imagem de verificação
              width: 150, // Ajuste o tamanho da imagem conforme necessário
              height: 150,
            ),

            SizedBox(height: 25),

            Text(
              'SENHA ALTERADA',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color:  Color.fromRGBO(50, 186, 124, 1),
              ),
            ),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(50, 186, 124, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ), // Cor verde definida por RGB
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Concluir',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
