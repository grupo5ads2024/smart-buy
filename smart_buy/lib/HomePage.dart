import 'package:flutter/material.dart';
import 'package:smart_buy/cadastroEstabelecimentos.dart';
import 'package:smart_buy/estabelecimentos.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartBuy',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHome2Page(title: 'SmartBuy'),
    );
  }
}

class MyHome2Page extends StatefulWidget {
  const MyHome2Page({super.key, required this.title});

  final String title;

  @override
  State<MyHome2Page> createState() => _MyHome2PageState();
}

class _MyHome2PageState extends State<MyHome2Page> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            accountName: Text('Admin'),
            accountEmail: Text('admin@gmail.com'),
            currentAccountPicture: CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(
                  'images/avatar_female_woman_person_people_white_tone_icon_159360.png'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Cadastrar Estabelecimentos'),
            subtitle: Text('Cadastrar novos estabelecimentos'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => cadastroEstabelecimento()));
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Estabelecimentos'),
            subtitle: Text('Lista de estabelecimentos cadastrados'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => estabelecimentos()));
            },
          )
        ]),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
