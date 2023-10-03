import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:subspace/list_model.dart';
class DatabaseHelper{

  static const _database = "SubSpace.db";
  static const databaseVersion = 1;

  // db instance
  late Database _db;

  Future<void> init()async{
    final documentDir = await getApplicationDocumentsDirectory();
    final path = join(documentDir.path ,_database );
    _db = await openDatabase(path , version: databaseVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute(
        ''' CREATE TABLE api_list ( 
          id TEXT  PRIMARY KEY, 
          title TEXT NOT NULL , 
          image_url TEXT NOT NULL, 
          favorite BOOLEAN ) '''
    );
  }

  // Future<int> insertList(apiModel) async {
  //   try {
  //     int result = await _db.insert('api_list', apiModel);
  //     return result;
  //   } catch (e) {
  //     print("Error inserting data: $e");
  //     return -1; // Return a negative value to indicate an error
  //   }
  // }

  Future<void> insertList(List<ListModel> modelList) async {
    try {
      // final db = await _getDb(); // Replace _getDb with your method to open the database
      Batch batch = _db.batch(); // Create a batch for efficient batch insert
      for (var model in modelList) {
        batch.insert('api_list', model.toJson(), conflictAlgorithm: ConflictAlgorithm.replace); // Assuming toMap() converts your model to a Map
      }
      await batch.commit(); // Commit the batch insert
      print('Inserted ${modelList.length} records successfully.');
    } catch (e) {
      print('Error inserting data: $e');
    }
  }

  Future<List<ListModel>?> getList() async {
    try{
     var results =    await _db.query('api_list');
      // Map the results to ListModel objects
      final List<ListModel> list = List.generate(results.length, (index) {
        return ListModel.fromMap(results[index]);
      });

      return list;
    }catch(e){
      print('Error inserting data: $e');
      return null;
    }
  }

  Future updateFavorites(favoriteValue, id)async  {
    try{
      await  _db.query('''UPDATE api_list
        SET favorite = $favoriteValue
        WHERE id = $id''');
    }
    catch(e){
      print('Error updating data: $e');
    }

  }
}