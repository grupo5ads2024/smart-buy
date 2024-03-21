import 'package:flutter/material.dart';
import 'package:smart_buy/redefinirSenha4.dart';

class RedefinirSenha3 extends StatefulWidget {
  const RedefinirSenha3({super.key});
  @override
  State<RedefinirSenha3> createState() => _RedefinirSenha3State();
}

class _RedefinirSenha3State extends State<RedefinirSenha3> {
  String password = '';
  String confirmPassword = '';

  PasswordStrength calculatePasswordStrength(String senha) {
    bool hasUppercase = false;
    bool hasLowercase = false;
    bool hasDigit = false;
    bool hasSpecialCharacter = false;

      for (int i = 0; i < senha.length; i++) {
      if (senha[i].toUpperCase() == senha[i] && senha[i].toLowerCase() != senha[i]) {
        hasUppercase = true;
      } else if (senha[i].toLowerCase() == senha[i] && senha[i].toUpperCase() != senha[i]) {
        hasLowercase = true;
      } else if (int.tryParse(senha[i]) != null) {
        hasDigit = true;
      } else {
        hasSpecialCharacter = true;
      }
    }
    
    if (senha.length >= 8) {
      if (hasUppercase && hasLowercase && hasDigit && hasSpecialCharacter) {
      return PasswordStrength.Strong;
      }
      if ((hasUppercase || hasLowercase) && hasDigit) {
        return PasswordStrength.Medium;
      }
    } else {
      return PasswordStrength.Weak;
    }

    return PasswordStrength.Weak;
  }

  Color getStrengthColor(PasswordStrength strength, int partIndex) {
    if (strength == PasswordStrength.Weak && partIndex == 0) {
      return Colors.red;
    } else if (strength == PasswordStrength.Medium && partIndex < 2) {
      return Colors.amber;
    } else if (strength == PasswordStrength.Strong) {
      return Colors.green;
    }
    return Colors.white; // Cor branca para níveis não pintados
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),

              Text(
                'Altere sua senha',
                style: TextStyle(
                  fontSize: 39,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE87C17),
                ),
                textAlign: TextAlign.left,
              ),

              SizedBox(height: 25),

              Text(
                'Digite abaixo sua nova senha:',
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 35),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30.0),
                  )
                ),
                onChanged: (senha) {
                  setState(() {
                    password = senha;
                  });
                },
              ),

              SizedBox(height: 10),

              Row(
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Container(
                      height: 5,
                      margin: EdgeInsets.only(right: index < 2 ? 10 : 0),
                      decoration: BoxDecoration(
                        color: getStrengthColor(calculatePasswordStrength(password), index),
                        borderRadius: BorderRadius.circular(5), // Borda arredondada
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 13),

              Text(
                '* A senha deve possuir no mínimo 8 caracteres. Incluindo números, letras maiúsculas, letras minúsculas e caracteres especiais.',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.red
                  ),
              ),

              SizedBox(height: 30),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30.0),
                  )
                ),
                onChanged: (senha) {
                  setState(() {
                    confirmPassword = senha;
                  });
                },
              ),
              SizedBox(height: 40),

            Container(
            width: double.infinity,
            height: 40.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RedefinirSenha4()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFE87C17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Enviar',
                style: TextStyle(fontSize: 18),
              ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

enum PasswordStrength {
  Weak,
  Medium,
  Strong,
}