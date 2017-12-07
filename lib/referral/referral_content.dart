import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folxdemo/folx_widgets/folx_button.dart';
import 'package:folxdemo/folx_widgets/folx_button_link.dart';
import 'package:folxdemo/folx_widgets/folx_text_field.dart' as folx_tf;
import 'package:folxdemo/util/folx_colors.dart';
import 'package:folxdemo/util/folx_text_styles.dart';

typedef void ResultCallback(bool isValid);

class ReferralContentWidget extends StatefulWidget {

  const ReferralContentWidget({
    @required this.onCloseClicked,
    @required this.onSendReferralCodeClicked,
    @required this.onNoReferralCodeClicked,
    @required this.onSendEmailClicked,
    @required this.isWaitingList,
    @required this.formKey,
    @required this.resultCallback
  });

  final bool isWaitingList;
  final VoidCallback onCloseClicked;
  final VoidCallback onSendReferralCodeClicked;
  final VoidCallback onNoReferralCodeClicked;
  final VoidCallback onSendEmailClicked;
  final GlobalKey<FormState> formKey;
  final ResultCallback resultCallback;

  @override
  _ReferralContentWidget createState() => new _ReferralContentWidget();
}

class _ReferralContentWidget extends State<ReferralContentWidget>
    with TickerProviderStateMixin {

  TextEditingController _textEditingController;
  bool _hasError = false;

  @override
  void initState() {
    _textEditingController = new TextEditingController();

    _textEditingController.addListener((){
      setState((){
        _hasError = false;
      });
    });
  }

  void _validateText(String value) {
    bool isValueCorrect = true;

    if(widget.isWaitingList) {
      isValueCorrect = value.contains("@") && value.length > 4;
    } else {
      isValueCorrect = value == "Beata123";
    }

    if (!isValueCorrect) {
      setState((){
        _hasError = true;
      });
    }

    widget.resultCallback(isValueCorrect);
  }

  @override
  Widget build(BuildContext context) {

    Widget close = new Align(alignment: Alignment.topRight,
      child: new Padding(
        padding: new EdgeInsets.only(
          left: 10.0,
          top: 10.0,
          right: 10.0,
          bottom: 16.0),

        child: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: widget.onCloseClicked)
      )
    );

    Widget margin = new Expanded(
      flex: 8,
      child: new Container(constraints: new BoxConstraints(minWidth: 8.0))
    );

    Widget headline = new Text(
      widget.isWaitingList
        ? "Chcesz dołączyć?"
        : "Dołącz\ndo Folx",
      style: FolxTextStyles.Title2
    );

    Widget body = new Padding(
      padding: new EdgeInsets.only(top: 32.0),

      child: new Text(
        widget.isWaitingList
            ? "Podaj adres e-mail, a damy Ci znać gdy będziesz już mógł korzystać z Folx"
            : "Wpisz kod, żeby korzystać z Folx za darmo",
        style: FolxTextStyles.Body
      )
    );

    String errorText = widget.isWaitingList
        ? "Niepoprawny adres e-mail"
        : "Kod polecający jest nieprawidłowy";

    Widget textField = new Padding(
      padding: new EdgeInsets.only(top: 32.0),

      child: new Form(
        key: widget.formKey,

        child: new folx_tf.TextFormField(
          style: FolxTextStyles.Body,
          onSaved: _validateText,
          controller:  _textEditingController,

          decoration: new folx_tf.InputDecoration(
            hintText: widget.isWaitingList
              ? "Wpisz adres e-mail"
              : "Wpisz kod",
            hintStyle: FolxTextStyles.Body.apply(color: FolxColors.liverA30),

            labelText: widget.isWaitingList
              ? "Adres e-mail"
              : "Twój kod do Folx:",
            labelStyle: FolxTextStyles.Footnote.apply(color: FolxColors.liverA60),

            errorText: !_hasError ? null : errorText,
            errorStyle: FolxTextStyles.Footnote.apply(color: FolxColors.coquelicot)
          )
        )
      )
    );

    Widget button = new Container(
      margin: new EdgeInsets.only(top: 32.0, bottom: widget.isWaitingList ? 40.0 : 0.0),

      child: new FolxButton(
        title: "Prześlij",
        isLightTheme: true,
        onPressed: widget.isWaitingList
          ? widget.onSendEmailClicked
          : widget
          .onSendReferralCodeClicked)
    );

    Widget noCodeWidget = new SizedBox.fromSize(
      size: new Size.fromHeight(80.0),

      child: new Center(

        child: new FolxButtonLink(
            title: "Nie masz kodu? **Daj nam znać**",
            isLightTheme: true,
            onPressed: widget.onNoReferralCodeClicked
        )
      )
    );

    if (widget.isWaitingList) {
      noCodeWidget = new Container();
    }

    return new Column(
      children: <Widget>[
        close,
        new Row(
          children: <Widget>[
            margin,

            new Expanded(
              flex: 84,

              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  headline,
                  body,
                  textField,
                  button,
                  noCodeWidget
                ]
              )
            ),

            margin
          ]
        )
      ]
    );
  }
}