import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folxdemo/referral/referral.dart';
import 'package:folxdemo/tutorial.dart';

class FolxRoutes {
  FolxRoutes._();


  static Route tutorialRoute() => _buildRoute(new TutorialWidget());
  static Route referralRoute() => _buildRoute(new ReferralCodeWidget());

  static Route _buildRoute(Widget widgetToShow) {
    return new PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        opaque: false,

        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widgetToShow;
        },

        transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new FadeTransition(
              opacity: animation,
              child: child
          );
        }
    );
  }
}