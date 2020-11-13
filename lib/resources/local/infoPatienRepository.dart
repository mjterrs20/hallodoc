import 'dart:io';

import 'package:hallodoc/models/infoPatient.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class InfoPatientRepository {
  static InfoPatientRepository _dbHelper;
  static Database _database;  

  InfoPatientRepository._createObject();

  factory InfoPatientRepository() {
    if (_dbHelper == null) {
      _dbHelper = InfoPatientRepository._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {

  //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'halodoc.db';

   //create, read databases
    var db = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return db;
  }

    //buat tabel baru dengan nama info_patient
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE info_patient (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        sex INTEGER,
        status TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('info_patient', orderBy: 'name');
    return mapList;
  }

//create databases
  Future<int> insert(InfoPatient object) async {
    Database db = await this.database;
    int count = await db.insert('info_patient', object.toMap());
    return count;
  }
//update databases
  Future<int> update(InfoPatient object) async {
    Database db = await this.database;
    int count = await db.update('info_patient', object.toMap(), 
                                where: 'id=?',
                                whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('info_patient', 
                                where: 'id=?', 
                                whereArgs: [id]);
    return count;
  }

  Future<List<InfoPatient>> getinfopatientList() async {
    var infoPatientMapList = await select();
    int count = infoPatientMapList.length;
    List<InfoPatient> infoPatientList = List<InfoPatient>();
    for (int i=0; i<count; i++) {
      infoPatientList.add(InfoPatient.fromMap(infoPatientMapList[i]));
    }
    return infoPatientList;
  }

  Future<List<InfoPatient>> getInfoPatient(id) async {
    Database db = await this.database;
    var infoPatientMapList = await db.rawQuery('SELECT * FROM info_patient where id=$id' );
    int count = infoPatientMapList.length;
    List<InfoPatient> infoPatientList = List<InfoPatient>();
    for (int i=0; i<count; i++) {
      infoPatientList.add(InfoPatient.fromMap(infoPatientMapList[i]));
    }
    return infoPatientList;
  }
}