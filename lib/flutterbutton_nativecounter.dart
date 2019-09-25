import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterButton_NativeCounter extends StatelessWidget {
  static const platform =
      const MethodChannel('appunite.flutter/incrementCounter');
  static const viewType = 'nativeCounter';

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter button - Native Counter"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _incrementAction, child: Icon(Icons.add)),
      body: Center(
        child: FractionallySizedBox(
            heightFactor: 0.5,
            widthFactor: 0.9,
            child: UiKitView(
              viewType: FlutterButton_NativeCounter.viewType,
            )),
      ),
    );
  }

  _incrementAction() {
    platform.invokeMethod("incrementCounter", ++_counter);
  }
}
