import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  List list;
  int index;
  AddData({this.index, this.list});
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerFname = new TextEditingController();
  TextEditingController controllerNric = new TextEditingController();
  TextEditingController controllerBodytemp = new TextEditingController();

  void addData(){
    var url="http://10.0.2.2/tapirGrocer/checkin.php";

    http.post(url, body: {
      "ownerID": widget.list[widget.index]['ownerID'],
      "fname": controllerFname.text,
      "nric": controllerNric.text,
      "bodytemp": controllerBodytemp.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Check In"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerFname,
                  decoration: new InputDecoration(
                      hintText: "Full Name", labelText: "Name"),
                ),
                new TextField(
                  controller: controllerNric,
                  decoration: new InputDecoration(
                      hintText: "NRIC Number", labelText: "NRIC"),
                ),
                new TextField(
                  controller: controllerBodytemp,
                  decoration: new InputDecoration(
                      hintText: "Body Temperature", labelText: "Temperature"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Submit"),
                  color: Colors.indigo,
                  onPressed: () {
                    addData();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}