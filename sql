import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class testing{
  static final db_name = 'sql_test.db';
  static final table_name = 'sqltest';
  static final col1 = 'id';
  static final col2 = 'date';
  static final col3 = 'time';
  static final col4 = 'day';
  static final col5 = 'content';
  static final dbVersion = 1;

  testing._privateConstructor();
   static final testing instance  = testing._privateConstructor();

   static Database ?_database;

   Future<Database?> get database async{
     if(_database==null){
       _database ??= await _initiateDatabase();
     }
     return _database;
   }

  _initiateDatabase()async{
     Directory directory = await getApplicationDocumentsDirectory();
     String path = join(directory.path,db_name);
     return await openDatabase(path, version: dbVersion, onCreate: _onCreate );
   }

  Future <dynamic> _onCreate(Database db, int version) async {
    db.execute(
        '''
         CREATE TABLE $table_name(
         $col1 INTEGER PRIMARY KEY ,
         $col2 TEXT NOT NULL,
         $col3 TEXT NOT NULL ,
         $col4 TEXT NOT NULL,
         $col5 TEXT NOT NULL
         )
         '''
    );
  }

Future<dynamic>infoInsert(Map<String,dynamic> row)async{
      Database? db = await instance.database;
      return await db!.insert(table_name, row);
}
Future<List<Map<String,dynamic>>>listAll()async{
     Database? db = await instance.database;
     return await db!.query(table_name);
}
Future<int>Update(Map<String,dynamic>row, String name)async{
     Database? db = await instance.database;
     return await db!.update(table_name,row ,where:'$col2 = ?',whereArgs: [name]);
   }
   Future<int>Delete(int index)async{
     Database? db = await instance.database;
     return await db!.delete(table_name,where:'$col1=?',whereArgs: [index]);
   }
}
