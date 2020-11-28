import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:tapir_grocer/location.dart';
import 'package:tapir_grocer/owner.dart';

class LaunchUrlDemo extends StatefulWidget {
  //
  LaunchUrlDemo({Key key}) : super(key: key);
  final String title = 'Tapir App';

  @override
  _LaunchUrlDemoState createState() => _LaunchUrlDemoState();
}

class _LaunchUrlDemoState extends State<LaunchUrlDemo> {
  //
  Future<void> _launched;
  String phoneNumber = '';
  String _launchUrl = 'https://www.google.com';

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.indigo,
      ),

      body: Container(
        alignment: Alignment(0.0, 0.0),

        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            RaisedButton(
              child: const Text('Customer Check-In'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocationList()),
                );

                // setState(() {
                //   _launched = _launchInBrowser(_launchUrl);
                // });
              },
            ),

            RaisedButton(
              child: const Text('Location Owner'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login()),
                );
                // setState(() {
                //   _launched = _launchInApp(_launchUrl);
                // });
              },
            ),

            SizedBox(
              height: 20.0,
            ),
            FutureBuilder(
              future: _launched,
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Welcome to Tapir Check-in App');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
