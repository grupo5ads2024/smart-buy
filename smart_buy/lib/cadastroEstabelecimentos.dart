import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'estabelecimentos.dart';

class cadastroEstabelecimento extends StatefulWidget {
  const cadastroEstabelecimento({super.key});

  @override
  State<cadastroEstabelecimento> createState() =>
      _cadastroEstabelecimentoState();
}

class _cadastroEstabelecimentoState extends State<cadastroEstabelecimento> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _horaAberturaController = TextEditingController();
  TextEditingController _horaFechamentoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SmartBuy'),
      ),
      body: Stack(children: <Widget>[
        ListView(children: [
          sizedBox(),
          nome(),
          endereco(),
          horaAbertura(),
          horaFechamento(),
        ])
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          addEstabelecimento(_nomeController.text, _enderecoController.text,
              _horaAberturaController.text, _horaFechamentoController.text);
          _nomeController.clear();
          _enderecoController.clear();
          _horaAberturaController.clear();
          _horaFechamentoController.clear();
          final snackBar = SnackBar(content: Text('Cadastrado com sucesso!'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }

  Widget sizedBox() {
    return SizedBox(
      height: 30,
    );
  }

  Widget nome() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _nomeController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nome do estabelecimento',
            icon: Icon(Icons.travel_explore)),
      ),
    );
  }

  Widget endereco() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _enderecoController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Endereço do Estabelecimento',
            icon: Icon(Icons.calendar_today)),
      ),
    );
  }

  Widget horaAbertura() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _horaAberturaController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Hora de Abertura',
            icon: Icon(Icons.timer_sharp)),
        onTap: () async {
          TimeOfDay? pickdTime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());
          if (pickdTime != null) {
            setState(() {
              _horaAberturaController.text = pickdTime.format(context);
            });
          }
        },
      ),
    );
  }

  Widget horaFechamento() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _horaFechamentoController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Hora de Fechamento',
            icon: Icon(Icons.timer_sharp)),
        onTap: () async {
          TimeOfDay? pickdTime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());
          if (pickdTime != null) {
            setState(() {
              _horaFechamentoController.text = pickdTime.format(context);
            });
          }
        },
      ),
    );
  }
}

void addEstabelecimento(
    String Nome, String Endereco, String horaAbertura, String horaFechamento) {
  Estabelecimentos t =
      Estabelecimentos(Nome, Endereco, horaAbertura, horaFechamento);
  listEstabelecimentos.add(t);
}
