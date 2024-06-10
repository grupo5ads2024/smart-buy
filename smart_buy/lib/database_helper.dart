import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Modelo para a tabela Usuário
class Usuario {
  int? id;
  String nome;
  String documento;
  String endereco;
  String telefone;
  String email;
  String senha;
  bool estabelecimento;
  DateTime? horaAbertura;
  DateTime? horaFechamento;
  String? imagemUsuario;

  Usuario({
    this.id,
    required this.nome,
    required this.documento,
    required this.endereco,
    required this.telefone,
    required this.email,
    required this.senha,
    required this.estabelecimento,
    this.horaAbertura,
    this.horaFechamento,
    this.imagemUsuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'documento': documento,
      'endereco': endereco,
      'telefone': telefone,
      'email': email,
      'senha': senha,
      'estabelecimento': estabelecimento ? 1 : 0,
      'horaAbertura': horaAbertura?.toIso8601String(),
      'horaFechamento': horaFechamento?.toIso8601String(),
      'imagemUsuario': imagemUsuario,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      documento: map['documento'],
      endereco: map['endereco'],
      telefone: map['telefone'],
      email: map['email'],
      senha: map['senha'],
      estabelecimento: map['estabelecimento'] == 1,
      horaAbertura: map['horaAbertura'] != null
          ? DateTime.parse(map['horaAbertura'])
          : null,
      horaFechamento: map['horaFechamento'] != null
          ? DateTime.parse(map['horaFechamento'])
          : null,
      imagemUsuario: map['imagemUsuario'],
    );
  }
}

// Modelo para a tabela Categoria
class Categoria {
  int? id;
  String nome;
  String descricao;
  String? imagemCategoria;

  Categoria({
    this.id,
    required this.nome,
    required this.descricao,
    this.imagemCategoria,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'imagemCategoria': imagemCategoria,
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      imagemCategoria: map['imagemCategoria'],
    );
  }
}

// Modelo para a tabela Produto
class Produto {
  int? id;
  String nome;
  String descricao;
  String? imagemProduto;
  double preco;
  int quantidade;
  int categoriaId;
  int usuarioId;

  Produto({
    this.id,
    required this.nome,
    required this.descricao,
    this.imagemProduto,
    required this.preco,
    required this.quantidade,
    required this.categoriaId,
    required this.usuarioId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'imagemProduto': imagemProduto,
      'preco': preco,
      'quantidade': quantidade,
      'categoriaId': categoriaId,
      'usuarioId': usuarioId,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      imagemProduto: map['imagemProduto'],
      preco: map['preco'],
      quantidade: map['quantidade'],
      categoriaId: map['categoriaId'],
      usuarioId: map['usuarioId'],
    );
  }
}

// Classe para gerenciar o banco de dados SQLite
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Usuario (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            documento TEXT NOT NULL,
            endereco TEXT NOT NULL,
            telefone TEXT NOT NULL,
            email TEXT NOT NULL,
            senha TEXT NOT NULL,
            estabelecimento INTEGER NOT NULL,
            horaAbertura TEXT,
            horaFechamento TEXT,
            imagemUsuario TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE Categoria (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            descricao TEXT NOT NULL,
            imagemCategoria TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE Produto (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            descricao TEXT NOT NULL,
            imagemProduto TEXT,
            preco REAL NOT NULL,
            quantidade INTEGER NOT NULL,
            categoriaId INTEGER NOT NULL,
            usuarioId INTEGER NOT NULL,
            FOREIGN KEY (categoriaId) REFERENCES Categoria(id),
            FOREIGN KEY (usuarioId) REFERENCES Usuario(id)
          )
        ''');
      },
    );
  }

  // Métodos CRUD para a tabela Usuário
  Future<int> inserirUsuario(Usuario usuario) async {
    final db = await database;
    return await db.insert('Usuario', usuario.toMap());
  }

  Future<Usuario?> buscarUsuarioPorId(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('Usuario', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Usuario>> buscarTodosUsuarios() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Usuario');
    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  }

  Future<int> atualizarUsuario(Usuario usuario) async {
    final db = await database;
    return await db.update('Usuario', usuario.toMap(),
        where: 'id = ?', whereArgs: [usuario.id]);
  }

  Future<int> deletarUsuario(int id) async {
    final db = await database;
    return await db.delete('Usuario', where: 'id = ?', whereArgs: [id]);
  }

  // Métodos CRUD para a tabela Categoria
  Future<int> inserirCategoria(Categoria categoria) async {
    final db = await database;
    return await db.insert('Categoria', categoria.toMap());
  }

  Future<Categoria?> buscarCategoriaPorId(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('Categoria', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Categoria.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Categoria>> buscarTodasCategorias() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Categoria');
    return List.generate(maps.length, (i) {
      return Categoria.fromMap(maps[i]);
    });
  }

  Future<int> atualizarCategoria(Categoria categoria) async {
    final db = await database;
    return await db.update('Categoria', categoria.toMap(),
        where: 'id = ?', whereArgs: [categoria.id]);
  }

  Future<int> deletarCategoria(int id) async {
    final db = await database;
    return await db.delete('Categoria', where: 'id = ?', whereArgs: [id]);
  }

  // Métodos CRUD para a tabela Produto
  Future<int> inserirProduto(Produto produto) async {
    final db = await database;
    return await db.insert('Produto', produto.toMap());
  }

  Future<Produto?> buscarProdutoPorId(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('Produto', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Produto.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Produto>> buscarTodosProdutos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Produto');
    return List.generate(maps.length, (i) {
      return Produto.fromMap(maps[i]);
    });
  }

  Future<int> atualizarProduto(Produto produto) async {
    final db = await database;
    return await db.update('Produto', produto.toMap(),
        where: 'id = ?', whereArgs: [produto.id]);
  }

  Future<int> deletarProduto(int id) async {
    final db = await database;
    return await db.delete('Produto', where: 'id = ?', whereArgs: [id]);
  }
}
