import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tapir_grocer/checkin_add.dart';
import 'package:tapir_grocer/owner.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
//String pid;
}

class _LocationListState extends State<LocationList> {
  String oid;
  Future<List> getData() async {
    final response =
    await http.post("http://10.0.2.2/tapirGrocer/ownerlist.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Location "),
        backgroundColor: Colors.indigo,
      ),

      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
            list: snapshot.data,
          )
              : new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, index) {
        return new Container(

          margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
          height: 100,
          width: double.maxFinite,
          child: new GestureDetector(

            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new AddData( list: list,
                  index: index,
                ))),

            child: new Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow,
                   // spreadRadius: 5,
                   // blurRadius: 7,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
                border: new Border.all(
                    color: Colors.indigo,
                    width: 2.0,
                    style: BorderStyle.solid),
              ),
              child: new ListTile(
                title: new Text(list[index]['name']),
                leading: new Icon(Icons.location_on),
                subtitle: new Text("Email : ${list[index]['email']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
