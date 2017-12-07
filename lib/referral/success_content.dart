import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folxdemo/routes.dart';
import 'package:folxdemo/util/folx_colors.dart';
import 'package:folxdemo/util/folx_text_styles.dart';
import 'package:meta/meta.dart';

class ReferralSuccessWidget extends StatelessWidget {

  const ReferralSuccessWidget({
    @required this.isWaitingListSuccess
  });

  final bool isWaitingListSuccess;

  @override
  Widget build(BuildContext context) {

    _closeSuccessAfterDelay(context);

    Widget margin = new Expanded(
      flex: 8,

      child: new Container(constraints: new BoxConstraints(minWidth: 8.0))
    );

    Widget icon = new Container(
      margin: const EdgeInsets.only(top: 40.0),

      child: new Align(
        alignment: Alignment.center,

        child: new Image.asset('images/icon_success.png')
      )
    );

    Widget text = new Container(
      margin: const EdgeInsets.only(top: 32.0, bottom: 40.0),

      child: new Align(
        alignment: Alignment.center,

        child: new Text(
          isWaitingListSuccess
            ? "Niedługo się z Tobą skontaktujemy"
            : "Kod jest w porządku",
          style: FolxTextStyles.Title2.apply(color: FolxColors.majorelleBlue),
          textAlign: TextAlign.center
        )
      )
    );

    return new Row(
      children: <Widget>[
        margin,

        new Expanded(
          flex: 84,

          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              icon,
              text
            ]
          )
        ),

        margin
      ]
    );
  }

  // Close screen after 5 seconds
  void _closeSuccessAfterDelay(BuildContext context) {
    new Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(FolxRoutes.tutorialRoute());
    });
  }
}
