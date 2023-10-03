import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subspace/list_model.dart';

var db_provider = ChangeNotifierProvider((ref) => DBProvider());

class DBProvider with ChangeNotifier{

  Future<List<ListModel>>insertIntoDb(list, databaseRef) async {
    await databaseRef.insertList(list);
    var value =  databaseRef.getList();
    print(value);
    return value;
  }


}
