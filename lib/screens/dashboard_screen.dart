import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subspace/list_model.dart';
import 'package:subspace/screens/db_helper.dart';
import 'package:subspace/screens/detailed_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


import '../api_provider.dart';

//offline , detailed view , fav

class DashboardScreen extends ConsumerStatefulWidget {
  DatabaseHelper db;
   DashboardScreen(this.db,{Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  var list = [];
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  Connectivity connectivity = Connectivity();

  @override
  initState(){
    super.initState();
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectivityResult = result;
      });
     // connectivityResult = result;
    });
    ref.read(apiProvider).fetchBlogs(widget.db, connectivityResult);

  }

  @override
  Widget build(BuildContext context) {
    List<ListModel> test = ref.watch(apiProvider).displayList;
    print(test);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.scatter_plot,color:Colors.white ,),
        backgroundColor:Colors.black87 ,
        title: Text("SubSpace",style: TextStyle(color: Colors.white, fontSize: 20)),
        elevation: 15,
        toolbarHeight: 60,
      ),
      body:
     // Container(
      // ConnectivityScreenWrapper(
      //   decoration: BoxDecoration(
      //     color: Colors.purple,
      //     gradient: new LinearGradient(
      //       colors: [Colors.red, Colors.cyan],
      //     ),
      //   ),
      //   child:
            Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          color: Colors.black38,
          child:test != null && test.isNotEmpty? ListView.builder(
              itemCount: test.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedScreen(test[index])));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) ,
                        color: Colors.black54,),
                    margin: EdgeInsets.only(left: 10,right: 10, top: 10),
                    child: Column(
                      children: [
                        Image.network(test[index].imageUrl,
                          height: MediaQuery.of(context).size.height*0.23 ,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height*0.05 ,
                            width: MediaQuery.of(context).size.width*0.97,
                          padding: EdgeInsets.all(12),
                            margin: EdgeInsets.all(8) ,
                            child: Text("${test[index].title}", style: TextStyle(color: Colors.white, fontSize: 16),)
                        )
                      ],
                    ),
                  ),
                );
              })
              :Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(color: Colors.white,)),
                  SizedBox(height: 20,),
                  Text("Please wait loading", style: TextStyle(color: Colors.black87 , fontSize: 18),)
                ],
              )
        )
      ),
    // )
    );
  }
}
