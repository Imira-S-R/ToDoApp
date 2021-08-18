import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:manage_my_time/models/shopping_item_model.dart';


class ShoppingItemDatabase {
  static final ShoppingItemDatabase instance = ShoppingItemDatabase._init();

  static Database? _database;

  ShoppingItemDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('shopping_item_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${ItemFields.id} $idType, 
  ${ItemFields.itemName} $textType,
  ${ItemFields.itemPrice} $integerType
  )
''');
  }

  Future<ShoppingItem> create(ShoppingItem shoppingItem) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNotes, shoppingItem.toJson());
    return shoppingItem.copy(id: id);
  }

  Future<ShoppingItem> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: ItemFields.values,
      where: '${ItemFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ShoppingItem.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ShoppingItem>> readAllNotes() async {
    final db = await instance.database;

    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes);

    return result.map((json) => ShoppingItem.fromJson(json)).toList();
  }

  Future<int> update(ShoppingItem shoppingItem) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      shoppingItem.toJson(),
      where: '${ItemFields.id} = ?',
      whereArgs: [shoppingItem.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${ItemFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
