import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapir_grocer/HomePageOwner.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, pass;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http
        .post("http://10.0.2.2/tapirGrocer/login.php", body: {
      "flag": 1.toString(),
      "email": email,
      "pass": pass,
      "token": "test_fcm_token"
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String emailAPI = data['email'];
    String nameAPI = data['name'];
    String ownerID = data['ownerID'];

    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, nameAPI, ownerID);
      });
      print(message);
      loginToast(message);
    } else {
      print("fail");
      print(message);
      loginToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  savePref(int value, String email, String name, String ownerID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("ownerID", ownerID);
      preferences.commit();
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("ownerID", null);

      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    print("App dah hancur");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Colors.indigo,
          body: SingleChildScrollView(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 15.0),
                children: <Widget>[
                  Center(
                    child: Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text(
                                        "Welcome to,",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text(
                                        "Tapir!",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 38,
                                            fontWeight: FontWeight.w500
                                        ),
                                      )
                                  ),
                                ],
                              ),],),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 400.0,
                            width: 340.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0),  bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50.0)),
                            ),
                            child: ListView(
                              primary: false,
                              padding: EdgeInsets.only(left: 25.0, right: 20.0),
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 45.0),
                                  child: Card(

                                    child: TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return "Please Insert Email";
                                        }
                                      },
                                      onSaved: (e) => email = e,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding:
                                            EdgeInsets.only(left: 20, right: 15),
                                            child:
                                            Icon(Icons.person, color: Colors.indigo),
                                          ),
                                          contentPadding: EdgeInsets.all(18),
                                          labelText: "Email"),
                                    ),
                                  ),
                                ),
                                // Card for password TextFormField
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Card(
                                    child: TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return "Password Can't be Empty";
                                        }
                                      },
                                      obscureText: _secureText,
                                      onSaved: (e) => pass = e,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(left: 20, right: 15),
                                          child: Icon(Icons.phonelink_lock,
                                              color: Colors.indigo),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: showHide,
                                          icon: Icon(_secureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                        contentPadding: EdgeInsets.all(18),
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(20.0),
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SizedBox(
                                      child: RaisedButton(
                                        onPressed: (){
                                          check();
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30)
                                        ),
                                        padding: EdgeInsets.all(0.8),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Colors.indigo,
                                                Colors.indigo
                                              ],
                                              ),
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            constraints: BoxConstraints(maxWidth: 270.0, minHeight: 45.0),
                                            child: Text(
                                              "Sign In",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                                Padding(
                                  padding: EdgeInsets.all(0.8),
                                ),

                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SizedBox(
                                      child: RaisedButton(
                                        onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Register()),
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30)
                                        ),
                                        padding: EdgeInsets.all(0.8),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Colors.amber,
                                                Colors.amber
                                              ],
                                              ),
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            constraints: BoxConstraints(maxWidth: 270.0, minHeight: 45.0),

                                            child: Text(
                                              "Sign Up",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.indigo,
                                                  fontSize: 18
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),  ],
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ),
        );
        break;

      case LoginStatus.signIn:
        return CheckinList(signOut);

        break;
    }
  }
}



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, email, pass;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    final response = await http
        .post("http://10.0.2.2/tapirGrocer/login.php", body: {
      "flag": 2.toString(),
      "name": name,
      "email": email,
      "pass": pass,
      "status": "1"

    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      print(message);
      registerToast(message);
    } else if (value == 2) {
      print(message);
      registerToast(message);
    } else {
      print(message);
      registerToast(message);
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: new Text("Back"),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Login()),
              );
            },
            icon: Icon(Icons.beenhere),
            color: Colors.white,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          // padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.all(14.0),
                color: Colors.white,
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Image.network(
                      //   "https://www.logogenie.net/download/preview/medium/3589659"),
                      //  SizedBox(
                      //    height: 40,
                      //  ),

                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Container(
                                  padding: EdgeInsets.only(left: 40),
                                  child: Text(
                                    "Owner Account!",
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                              ),
                            ],
                          ),],),

                      SizedBox(
                        height: 10,
                      ),

                      //card for Fullname TextFormField
                      Card(
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Full Name";
                            }
                          },
                          onSaved: (e) => name = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.person, color: Colors.indigo),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Fullname"),
                        ),
                      ),


                      //card for Email TextFormField
                      Card(
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Email";
                            }
                          },
                          onSaved: (e) => email = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.email, color: Colors.indigo),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Email"),
                        ),
                      ),

                      //card for Mobile TextFormField


                      //card for Password TextFormField
                      Card(
                        child: TextFormField(
                          obscureText: _secureText,
                          onSaved: (e) => pass = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.phonelink_lock,
                                    color: Colors.indigo),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Password"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.8),
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            child: RaisedButton(
                              onPressed: (){

                                check();
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              padding: EdgeInsets.all(0.8),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.amber,
                                      Colors.amber
                                    ],
                                    ),
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  constraints: BoxConstraints(maxWidth: 270.0, minHeight: 45.0),
                                  child: Text(
                                    "Sign In",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 18
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}










