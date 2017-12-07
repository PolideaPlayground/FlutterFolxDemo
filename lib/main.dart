import 'package:flutter/material.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:folxdemo/splash.dart';

void main() {
  runApp(new FolxApp());
}

class FolxApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //change status bar icons style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return new MaterialApp(
        title: 'Folx',
        home: new SplashWidget()
    );
  }
}