import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CadastroUsuario extends StatefulWidget {
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'nome',
                decoration: InputDecoration(labelText: 'Nome'),
                validator: FormBuilderValidators.required(context),
              ),
              FormBuilderTextField(
                name: 'email',
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: FormBuilderValidators.email(context),
              ),
              FormBuilderTextField(
                name: 'senha',
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: FormBuilderValidators.minLength(
                  context,
                  6,
                  errorText: 'A senha deve ter pelo menos 6 caracteres.',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    // Enviar dados para o backend ou realizar outra ação
                    print(
                        'Formulário válido, dados: ${_formKey.currentState!.value}');
                    // Aqui você pode redirecionar para a próxima tela ou realizar outras ações após o cadastro
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
