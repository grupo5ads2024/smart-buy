import 'package:flutter/material.dart';
import 'package:smart_buy/CadastroUsuario.dart';
import 'package:smart_buy/HomePage.dart';
import 'package:smart_buy/HomeConsumidor.dart';
import 'package:smart_buy/redefinirSenha.dart';
import 'package:smart_buy/database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  Widget _buildText(BuildContext context, String text,
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * (fontSize ?? 0.04),
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildText(context, "Não possui um cadastro? ",
            fontSize: 0.04, color: Colors.grey),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastrarUsuario()));
          },
          child: _buildText(context, "Cadastre-se.",
              fontSize: 0.04,
              color: Color(0xFFE87C17),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, String labelText,
      IconData prefixIcon, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 8.0),
              child: Icon(prefixIcon),
            ),
            labelText: labelText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildText(context, "Esqueceu sua senha? ",
            fontSize: 0.04, color: Colors.grey),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RedefinirSenha()));
          },
          child: _buildText(context, "Clique aqui.",
              fontSize: 0.04,
              color: Color(0xFFE87C17),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

 Widget _buildLoginButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final dbHelper = DatabaseHelper();
            final usuarios = await dbHelper.buscarTodosUsuarios();

            final usuario = usuarios.firstWhere(
              (user) =>
                  user.email == _emailController.text &&
                  user.senha == _senhaController.text,
              orElse: () => Usuario(
                  nome: '',
                  documento: '',
                  endereco: '',
                  telefone: '',
                  email: '',
                  senha: '',
                  estabelecimento: false),
            );

            if (usuario.nome.isNotEmpty) {
              // Navegar para a tela principal, passando o usuário logado
              if (usuario.estabelecimento) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomePage(usuarioLogado: usuario),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeConsumidor(usuarioLogado: usuario),
                  ),
                );
              }
            } else {
              // Mostrar mensagem de erro de login
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Usuário ou senha inválidos!')),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFE87C17),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          'Entrar',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/google.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 20),
        ClipOval(
          child: Image.asset(
            'assets/images/facebook.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Image.asset(
                'assets/images/smartbuy.png',
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(height: 15),
              _buildText(context, "BEM VINDO!",
                  fontSize: 0.08,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE87C17)),
              SizedBox(height: 5),
              _buildSignUpLink(context),
              SizedBox(height: 30),
              _buildText(context, "LOGIN",
                  fontSize: 0.07,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE87C17)),
              SizedBox(height: 30),
              _buildTextField(context, "Email", Icons.person, _emailController),
              SizedBox(height: 30),
              _buildTextField(context, "Senha", Icons.lock, _senhaController,
                  obscureText: true),
              SizedBox(height: 10),
              _buildForgotPasswordLink(context),
              SizedBox(height: 30),
              _buildLoginButton(context),
              SizedBox(height: 30),
              _buildSocialIcons(),
            ],
          ),
        ),
      ),
    );
  }
}
