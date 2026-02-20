import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/employee.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('employees.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        role TEXT NOT NULL,
        date_of_joining TEXT NOT NULL,
        is_active INTEGER NOT NULL
      )
    ''');

    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    final sampleEmployees = [
      Employee(
        name: 'Alice Johnson',
        role: 'Software Engineer',
        dateOfJoining: DateTime(2018, 3, 15),
        isActive: true,
      ),
      Employee(
        name: 'Bob Smith',
        role: 'Product Manager',
        dateOfJoining: DateTime(2020, 7, 1),
        isActive: true,
      ),
      Employee(
        name: 'Carol Williams',
        role: 'UX Designer',
        dateOfJoining: DateTime(2016, 1, 10),
        isActive: true,
      ),
      Employee(
        name: 'David Brown',
        role: 'DevOps Engineer',
        dateOfJoining: DateTime(2019, 11, 20),
        isActive: false,
      ),
      Employee(
        name: 'Eva Martinez',
        role: 'QA Lead',
        dateOfJoining: DateTime(2015, 5, 5),
        isActive: true,
      ),
      Employee(
        name: 'Frank Lee',
        role: 'Data Analyst',
        dateOfJoining: DateTime(2022, 2, 14),
        isActive: true,
      ),
      Employee(
        name: 'Grace Chen',
        role: 'HR Manager',
        dateOfJoining: DateTime(2017, 8, 30),
        isActive: false,
      ),
      Employee(
        name: 'Henry Wilson',
        role: 'Backend Developer',
        dateOfJoining: DateTime(2014, 6, 12),
        isActive: true,
      ),
      Employee(
        name: 'Irene Davis',
        role: 'Frontend Developer',
        dateOfJoining: DateTime(2021, 9, 1),
        isActive: true,
      ),
      Employee(
        name: 'Jack Thompson',
        role: 'CTO',
        dateOfJoining: DateTime(2013, 4, 22),
        isActive: true,
      ),
    ];

    for (final employee in sampleEmployees) {
      await db.insert('employees', employee.toMap());
    }
  }

  Future<List<Employee>> getAllEmployees() async {
    final db = await database;
    final result = await db.query('employees', orderBy: 'name ASC');
    return result.map((map) => Employee.fromMap(map)).toList();
  }

  Future<int> insertEmployee(Employee employee) async {
    final db = await database;
    return await db.insert('employees', employee.toMap());
  }

  Future<int> updateEmployee(Employee employee) async {
    final db = await database;
    return await db.update(
      'employees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> deleteEmployee(int id) async {
    final db = await database;
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
