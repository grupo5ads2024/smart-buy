import 'package:flutter/material.dart';

List<Estabelecimentos> listEstabelecimentos = [];

class estabelecimentos extends StatefulWidget {
  const estabelecimentos({super.key});

  @override
  State<estabelecimentos> createState() => _estabelecimentosState();
}

class _estabelecimentosState extends State<estabelecimentos> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _horaAberturaController = TextEditingController();
  TextEditingController _horaFechamentoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estabelecimentos'),
      ),
      body: ListView.builder(
        itemCount: listEstabelecimentos.length,
        itemBuilder: (BuildContext context, int index) {
          String nome = listEstabelecimentos[index].nome;
          String endereco = listEstabelecimentos[index].endereco;
          String horaAbertura = listEstabelecimentos[index].horaAbertura;
          String horaFechamento = listEstabelecimentos[index].horaFechamento;
          return Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                listEstabelecimentos.removeAt(index);
              },
              child: ListTile(
                leading: CircleAvatar(child: Text(index.toString())),
                title: Text('Nome $nome'),
                subtitle: Text(
                    '$endereco ( Horario: $horaAbertura - $horaFechamento )'),
              ));
        },
      ),
    );
  }
}

class Estabelecimentos {
  String nome;
  String endereco;
  String horaAbertura;
  String horaFechamento;
  Estabelecimentos(
      this.nome, this.endereco, this.horaAbertura, this.horaFechamento);
}
