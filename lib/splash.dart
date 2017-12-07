import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folxdemo/routes.dart';
import 'package:folxdemo/util/folx_colors.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    _closeSplashAfterDelay(context);

    bool isPlatformIOS = Theme.of(context).platform == TargetPlatform.iOS;

    Widget logo = new Container(
        margin: const EdgeInsets.only(bottom: 40.0),
        child: new Image.asset('images/folx_logo.png')
    );

    Widget progress = new SizedBox(
      width: 24.0,
      height: 24.0,

      child: isPlatformIOS
        ? new CupertinoActivityIndicator()
        : new Theme(
        data: new ThemeData(accentColor: FolxColors.liver),
        child: new CircularProgressIndicator()
      )
    );

    return new Container(
      decoration: new BoxDecoration(color: FolxColors.white),

      child: new Center(

        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            logo,
            progress
          ]
        )
      )
    );
  }

  // Close screen after 5 seconds
  void _closeSplashAfterDelay(BuildContext context) {
    new Timer(const Duration(seconds: 5), () {
      _resolveBackgroundImage();

      //change status bar icons style
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

      Navigator.of(context).pushReplacement(FolxRoutes.tutorialRoute());
    });
  }

  void _resolveBackgroundImage() {
    //Resolve image here so when we go to next screen it's immediately available
    AssetImage image = new AssetImage("images/background.png");
    image.resolve(ImageConfiguration.empty);
  }
}