import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeButton_FlutterCounter extends StatefulWidget {
  static const platform = const MethodChannel('appunite.flutter/showCounter');
  static const viewType = 'nativeButton';

  @override
  _NativeButton_FlutterCounterState createState() =>
      _NativeButton_FlutterCounterState();
}

class _NativeButton_FlutterCounterState
    extends State<NativeButton_FlutterCounter> {
  String _title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter button - Native Counter"),
      ),
      floatingActionButton: Container(
        width: 90,
        height: 90,
        child: GestureDetector(
            onDoubleTap: () => _updateTitle("Double tap from Flutter"),
            child: UiKitView(
              onPlatformViewCreated: (_) => _setupIncrementAction(),
              viewType: NativeButton_FlutterCounter.viewType,
            )),
      ),
      body: Center(
        child: FractionallySizedBox(
            heightFactor: 0.5,
            widthFactor: 0.9,
            child: Column(
              children: <Widget>[
                Text("You have pushed the button this many times:"),
                SizedBox(
                  height: 16,
                ),
                Text(
                  _title,
                  style: TextStyle(fontSize: 22),
                )
              ],
            )),
      ),
    );
  }

  _setupIncrementAction() async {
    NativeButton_FlutterCounter.platform.setMethodCallHandler((call) async {
      _updateTitle(call.arguments.toString());
    });
  }

  _updateTitle(String text) {
    setState(() {
      _title = text;
    });
  }
}
