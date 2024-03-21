import 'package:flutter/material.dart';
import 'package:smart_buy/HomePage.dart';
import 'package:smart_buy/RedefinirSenha.dart';
import 'package:smart_buy/CadastrarUsuario.dart';
import 'package:smart_buy/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          SizedBox(height: 20),

          Image.asset('assets/images/smartbuy.png',
          width: 150,
          height: 100,
          ),

          SizedBox(height: 15),

          Text(
            "BEM VINDO!",
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 50,
              color: Color(0xFFE87C17)
            ),
          ),

            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Não possui um cadastro? ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              // GestureDetector para "Cadastre-se" como um link
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastrarUsuario()),
                  );
                },
                child: Text(
                  "Cadastre-se.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFFE87C17),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 30),

          Text(
            "LOGIN",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE87C17)
              ),
          ),

          SizedBox(height: 20),

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
                  decoration: InputDecoration (
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                      child: Icon(Icons.person),
                    ),
                    labelText: "Usuário",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
                child: TextField(
                  decoration: InputDecoration (
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                      child: Icon(Icons.lock),
                    ),
                    labelText: "Senha",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),

          SizedBox(height: 10), 
                   
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Esqueceu sua senha? ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              // GestureDetector para "Cadastre-se" como um link
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RedefinirSenha()),
                  );
                },
                child: Text(
                  "Clique aqui.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFFE87C17),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 30),

          Container(
            width: double.infinity,
            height: 40.0,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFE87C17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),

          SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Container(
                  height: 1.5, // Altura da linha
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(width: 10), // Espaçamento entre a linha à esquerda e o texto "ou"
            Text(
              "OU",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(width: 10), // Espaçamento entre o texto "ou" e a linha à direita
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 40),
                child: Container(
                  height: 1.5, // Altura da linha
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),

          SizedBox(height: 20),

          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset('assets/images/google.png',
                width: 40, // Defina o tamanho desejado
                height: 40, // Defina o tamanho desejado
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20), // Adiciona um espaçamento entre as logos
            ClipOval(
              child: Image.asset('assets/images/facebook.png',
                width: 40, // Defina o tamanho desejado
                height: 40, // Defina o tamanho desejado
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}