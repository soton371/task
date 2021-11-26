import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';

import 'package:task/product_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List data;

  Future fatchData() async {
    var jsonData = await rootBundle.loadString("assets/json_files/products.json");
    setState(() {
      data = json.decode(jsonData);
    });
  }

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Home Page',
        style: TextStyle(
          color: Colors.black
        ),
        ),
      ),
      body: data==null?Center(child: CircularProgressIndicator()): GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0
          ),
          itemCount: data.length,
          itemBuilder: (_,index)=>Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetails(get_index: index,))),
                      child: Align(
                          alignment: Alignment.center,
                          child: Image(image: AssetImage(data[index]["image"]),height: 100,))),
                  Spacer(),
                  Text(data[index]["name"],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                  ),
                  Text(data[index]["description"],maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                  ),
                  Text("\$${data[index]["price"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                  ),
                ],
              ),
            ),
          )
      )
    );
  }
}
