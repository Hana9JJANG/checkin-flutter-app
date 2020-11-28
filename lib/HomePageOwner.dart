import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapir_grocer/owner.dart';


class CheckinList extends StatefulWidget {
  final VoidCallback signOut;

  CheckinList(this.signOut);
  @override
  _CheckinListState createState() => _CheckinListState();
//String pid;
}

class _CheckinListState extends State<CheckinList> {

  signOut() {
    setState(() {
      widget.signOut();
    });
  }
  String oid;
  Future<List> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString("ownerID");
    oid = stringValue;
    final response = await http.post(
        "http://10.0.2.2/tapirGrocer/checkinlist.php",
        body: {"ownerID": oid});
    return json.decode(response.body);
  }


  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Checkin List"),
        backgroundColor: Colors.indigo,
      ),

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor:Colors.indigo,
        unselectedItemColor:Colors.indigo,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: [
          _bottomIcons(Icons.home),
          _bottomIcons(Icons.exit_to_app),
        ],
        onTap: (index) {
          if (index == 0) {

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          } else if (index == 1) {
            signOut();
          } else if (index == 2) {
            signOut();
          }
        },
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
                builder: (context) => Login())),
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
                  new BoxShadow(
                    color: Colors.yellow,
                    offset: new Offset(5, 5),
                  )
                ],
                border: new Border.all(
                    color: Colors.indigo,
                    width: 2.0,
                    style: BorderStyle.solid),
              ),
              child: new ListTile(
                title: new Text(list[index]['fname']),
                leading: new Icon(Icons.beenhere),
                subtitle: new Text("Date & Time : ${list[index]['date']}"),
                trailing: Text("Temperature\n  ${list[index]['bodytemp']}"),

              ),


            ),
          ),
        );
      },
    );
  }
}
