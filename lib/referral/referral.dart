import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folxdemo/referral/referral_content.dart';
import 'package:folxdemo/referral/success_content.dart';
import 'package:folxdemo/routes.dart';
import 'package:folxdemo/util/folx_colors.dart';

enum ReferralCodeState {
  REFERRAL,
  WAITING_LIST,
  SUCCESS
}

class ReferralCodeWidget extends StatefulWidget {

  @override
  _ReferralCodeWidget createState() => new _ReferralCodeWidget();
}

class _ReferralCodeWidget extends State<ReferralCodeWidget>
    with TickerProviderStateMixin {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  ReferralCodeState _previousState = ReferralCodeState.REFERRAL;
  ReferralCodeState _state = ReferralCodeState.REFERRAL;

  AnimationController fadeController;

  Animation fadeOutAnimation;

  bool _isInProgress = false;

  @override
  void initState() {
    fadeController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 200));

    fadeController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        setState(() {
          // just refresh widget
        });
        fadeController.reverse();
      }
    });

    fadeOutAnimation = new Tween(begin: 1.0, end: 0.0).animate(fadeController);
  }

  void _onCloseClicked() {
    Navigator.of(context).pushReplacement(FolxRoutes.tutorialRoute());
  }

  void _onSendReferralCodeClicked() {
    final FormState form = _formKey.currentState;
    form.save();
  }

  void _onNoReferralCodeClicked() {
    _previousState = _state;
    _state = ReferralCodeState.WAITING_LIST;
    fadeController.forward();
  }

  void _onSendEmailClicked() {
    final FormState form = _formKey.currentState;
    form.save();
  }

  void _result(bool isValid) {
    if(isValid) {

      setState(() {
        _isInProgress = true;
      });

      new Timer(const Duration(seconds: 3), () {
        _isInProgress = false;
        _previousState = _state;
        _state = ReferralCodeState.SUCCESS;
        fadeController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget contentWidget = new ReferralContentWidget(
      onCloseClicked: _onCloseClicked,
      onSendReferralCodeClicked: _isInProgress ? null : _onSendReferralCodeClicked,
      onNoReferralCodeClicked: _onNoReferralCodeClicked,
      onSendEmailClicked: _isInProgress ? null : _onSendEmailClicked,
      isWaitingList: _state == ReferralCodeState.WAITING_LIST,
      formKey: _formKey,
      resultCallback: _result
    );

    if (_state == ReferralCodeState.SUCCESS) {
      contentWidget = new ReferralSuccessWidget(
          isWaitingListSuccess: _previousState ==
              ReferralCodeState.WAITING_LIST);
    }

    return _buildContentWith(contentWidget);
  }


  Widget _buildContentWith(Widget contentChild) {
    BoxDecoration folxBackgroundDecoration = new BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage("images/background.png"),
            fit: BoxFit.cover
        )
    );

    Widget verticalMargin = new Expanded(
        flex: 1,
        child: new Container(constraints: new BoxConstraints(minWidth: 32.0))
    );

    Widget horizontalMargin = new Expanded(
        flex: 8,
        child: new Container(constraints: new BoxConstraints(minWidth: 8.0))
    );

    BoxDecoration roundedRectBackgroundDecoration = new BoxDecoration(
        color: FolxColors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(10.0))
    );

    return new Container(
        decoration: folxBackgroundDecoration,

        child: new Scaffold(
            backgroundColor: FolxColors.transparent,

            body: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  verticalMargin,

                  new Row(
                      children: <Widget>[
                        horizontalMargin,

                        new Expanded(
                            flex: 84,
                            child: new Container(
                                decoration: roundedRectBackgroundDecoration,

                                child: new FadeTransition(opacity: fadeOutAnimation, child: contentChild)
                            )
                        ),

                        horizontalMargin
                      ]
                  ),

                  verticalMargin
                ]
            )
        )
    );
  }
}