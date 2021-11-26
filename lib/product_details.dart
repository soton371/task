import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  var get_index;
  ProductDetails({this.get_index});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  List data;

  Future fatchData() async {
    var jsonData = await rootBundle.loadString("assets/json_files/products.json");
    setState(() {
      data = json.decode(jsonData);
    });
  }

  void showAlertDialog(_)=>showDialog(
      context: context,
      builder: (_)=>AlertDialog(
        title: Center(child: Text("\$${data[widget.get_index]["price"]}")),
      )
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fatchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
            onPressed: ()=>showAlertDialog(context),
            child: Text("Buy"),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image(image: AssetImage(data[widget.get_index]["image"]),height: 200,)),
              SizedBox(height: 20,),
              Text(data[widget.get_index]["name"],
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              ),

              Text("\$${data[widget.get_index]["price"]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
                ),
              ),
              SizedBox(height: 15,),
              Text("Description",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Text(data[widget.get_index]["description"]),
            ],
          ),
        ),
      )
    );
  }
}
