import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flutterbutton_nativecounter.dart';
import 'nativebutton_fluttercounter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Platform Channel/View examples", home: HomeView());
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Platform Channels/Views"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Flutter button -> Native counter"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlutterButton_NativeCounter()),
                );
              },
            ),

            ListTile(
              title: Text("Native button -> Flutter counter"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NativeButton_FlutterCounter()),
                );
              },
            ),

            ListTile(
              title: Text("Show native view"),
              onTap: () {
                MethodChannel('appunite.flutter/nativeView')
                    .invokeMethod("nativeView");
              },
            )
          ],
        ),
      ),
    );
  }
}
