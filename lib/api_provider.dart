import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subspace/list_model.dart';
import 'package:subspace/provider/db_provider.dart';
import 'package:subspace/screens/db_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';



var apiProvider = ChangeNotifierProvider((ref) => CallApi());

class CallApi with ChangeNotifier {

  List<ListModel> displayList=[];

  fetchBlogs(DatabaseHelper databaseRef,connectivityResult) async {
    //check internet state and response from db when no internet
    if(connectivityResult != ConnectivityResult.none){
      final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
      final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
      List<ListModel> list =[];
      try {
        final response = await http.get(Uri.parse(url), headers: {
          'x-hasura-admin-secret': adminSecret,
        });
        if (response.statusCode == 200) {
          // Request successful, handle the response data here
          print('Response data: ${response.body}');
          var apiList = jsonDecode(response.body)['blogs'];
          apiList.forEach((value) {
            list.add(ListModel.fromJson(value)) ;
          }) ;
          displayList.addAll(list);
          await databaseRef.insertList(list);
          notifyListeners();
        } else {
          // Request failed
          print('Request failed with status code: ${response.statusCode}');
          print('Response data: ${response.body}');
        }
      } catch (e) {
        // Handle any errors that occurred during the request
        print('Error: $e');
      }
    }else{
      var value =  await databaseRef.getList();
      print(value);
      if(value!=null)
      displayList.addAll(value);
      return value;
    }


  }
}



