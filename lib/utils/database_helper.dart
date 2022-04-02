
import 'package:contact_list_sqflite/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static const tableName = "contact";

  static final DatabaseHelper _dbHelper = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _dbHelper;
  }

  DatabaseHelper._internal();

  late Database _db;

  Future<Database> get db async {
    _db = await _initDB();
    return _db;
  }

  _initDB() async {
    final dbPath = await getDatabasesPath();
    final dbLocal = join(dbPath, "$tableName.db");

    var db = await openDatabase(dbLocal, version: 1, onCreate: _onCreateDB);
    return db;
  }

  _onCreateDB(Database db, int version) async {
    String sql =
        "CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, phoneNumber VARCHER, data DATETIME)";
    await db.execute(sql);
  }

  Future<int> addContact(Contact contact) async {
    var database = await db;
    int result = await database.insert(tableName, contact.toMap());
    return result;
  }

  Future<bool> updateContact(Contact contact) async {
    var database = await db;
     int id = contact.id;
     String name = contact.name;
     String phoneNumber = contact.phoneNumber;

    String sql = "UPDATE $tableName SET name = '$name' , phoneNumber = '$phoneNumber' WHERE id = $id ";
    await database.execute(sql);
    return true;
  }

  Future<bool> deleteContact(int id) async {
    var database = await db;

    String sql = "DELETE FROM $tableName WHERE id = $id ";
    await database.execute(sql);
    return true;
  }

  Future<List<Contact>> fetchAll() async {
    List<Contact> list = [];

    var database = await db;
    const sql = "SELECT * FROM $tableName ORDER BY name";
    List contacts = await database.rawQuery(sql);
    list = contacts.map( (contact) {
        return Contact.fromMap(contact);
    }).toList(); 

    return list;
  }

}
