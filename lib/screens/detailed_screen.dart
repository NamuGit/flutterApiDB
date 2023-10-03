import 'package:flutter/material.dart';
import 'package:subspace/list_model.dart';
class DetailedScreen extends StatefulWidget {
  ListModel modelValues;
  DetailedScreen( this.modelValues ,{Key? key}) : super(key: key);

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey,
          // padding: EdgeInsets.all(2),
          child: Stack(
            children: [
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height*0.4,
              //   child: Text("${widget.modelValues.title}"),
              //   color: Colors.red,
              // ),
              Image.network(widget.modelValues.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.4,
                fit: BoxFit.fill,
              ),
              Positioned(
                left:0,
                top: MediaQuery.of(context).size.height*0.3,
                right: 0,
                // bottom: 10,
                child: Container(
                    padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50)) ,
                    color: Colors.white,),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.all(10),
                  child:Text("${widget.modelValues.title}"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
