import 'package:resto_admin/models/operasional.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
    // Singleton DatabaseHelper
    static DatabaseHelper _databaseHelper;
    // Singleton Database
    static Database _database;

    String tableName = 'jam_operasional';
	String id = 'id';
	String id_operasional = 'id_operasional';
	String jam_buka = 'jam_buka';
    String jam_tutup = 'jam_tutup';

	DatabaseHelper._createInstance();

	factory DatabaseHelper() {
        if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
    }

    Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'resto_admin.db';

        print('buat database resto_admin.db');

		var financesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return financesDatabase;
	}

	void _createDb(Database db, int newVersion) async {
		await db.execute('CREATE TABLE $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $id_operasional INTEGER, '
				'$jam_buka TEXT)');
	}

	Future<List<Map<String, dynamic>>> getTodoMapList() async {
		Database db = await this.database;

		var result = await db.query(tableName, orderBy: '$id_operasional ASC');
		return result;
	}

	// Future<int> insertTodo(Operasional operasional) async {
	// 	Database db = await this.database;
	// 	var result = await db.insert(tableName, operasional.toMap());
	// 	return result;
	// }

	Future<int> deleteTodo(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $tableName WHERE $this.id = $id');
		return result;
	}

	// Future<List<Operasional>> getTodoList() async {

	// 	var todoMapList = await getTodoMapList(); // Get 'Map List' from database
	// 	int count = todoMapList.length;         // Count the number of map entries in db table

	// 	List<Operasional> todoList = List<Operasional>();
	// 	// For loop to create a 'todo List' from a 'Map List'
	// 	for (int i = 0; i < count; i++) {
	// 		todoList.add(Operasional.fromMapObject(todoMapList[i]));
	// 	}

	// 	return todoList;
	// }
}