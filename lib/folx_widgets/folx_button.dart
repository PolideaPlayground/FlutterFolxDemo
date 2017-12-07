import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:folxdemo/util/folx_colors.dart';
import 'package:folxdemo/util/folx_text_styles.dart';


class FolxButton extends StatefulWidget {
  const FolxButton({
    Key key,
    @required this.onPressed,
    @required this.isLightTheme,
    @required this.title,
  }) : super(key: key);


  final String title;

  /// The callback that is called when the button is tapped or otherwise
  /// activated.
  ///
  /// If this is set to null, the button will be disabled.
  final VoidCallback onPressed;

  final isLightTheme;

  bool get enabled => onPressed != null;

  @override
  _FolxButtonState createState() => new _FolxButtonState();
}

class _FolxButtonState extends State<FolxButton> {

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    setState(() {
      if (!_buttonHeldDown) {
        _buttonHeldDown = true;
      }
    });
  }

  void _handleTapUp(TapUpDetails event) {
    setState(() {
      if (_buttonHeldDown) {
        _buttonHeldDown = false;
      }
    });
  }

  void _handleTapCancel() {
    setState(() {
      if (_buttonHeldDown) {
        _buttonHeldDown = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color buttonEnabledColor = widget.isLightTheme
    ? FolxColors.majorelleBlue
    : FolxColors.white;
    Color buttonPressedColor = widget.isLightTheme
      ? FolxColors.persianBlue
      : FolxColors.paleLavender;
    Color buttonDisabledColor = widget.isLightTheme
      ? FolxColors.periwinkle
      : FolxColors.whiteA20;

    Color titleEnabledColor = widget.isLightTheme
      ? FolxColors.white
      : FolxColors.majorelleBlue;
    Color titlePressedColor = widget.isLightTheme
      ? FolxColors.white
      : FolxColors.majorelleBlue;
    Color titleDisabledColor = widget.isLightTheme
      ? FolxColors.whiteA80
      : FolxColors.whiteA80;


    Color titleColor = titleEnabledColor;
    Color buttonColor = buttonEnabledColor;

    if (!widget.enabled) {
      titleColor = titleDisabledColor;
      buttonColor = buttonDisabledColor;
    } else if (_buttonHeldDown) {
      titleColor = titlePressedColor;
      buttonColor = buttonPressedColor;
    }

    TextStyle buttonTextStyle = FolxTextStyles.BodyStrong.apply(
        color: titleColor);

    Widget textWidget = new Container(
      constraints: new BoxConstraints(minHeight: 40.0),
      decoration: new BoxDecoration(
        color: buttonColor,
        borderRadius: new BorderRadius.all(new Radius.circular(6.0))
      ),

      child: new Center(
        child: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Text(widget.title, style: buttonTextStyle)
        )
      )
    );

    bool isPlatformIOS = Theme
      .of(context)
      .platform == TargetPlatform.iOS;

    Widget progressIndicator = new Container(
      constraints: new BoxConstraints(minHeight: 40.0),
      child:
      !widget.enabled
        ? new Align(
        alignment: Alignment.centerRight,
        child: new Padding(
          padding: new EdgeInsets.only(right: 16.0),
          child: new SizedBox(
            width: 16.0,
            height: 16.0,
            child: isPlatformIOS
              ? new CupertinoActivityIndicator()
              : new Theme(
              data: new ThemeData(
                accentColor: buttonTextStyle.color),
              child: new CircularProgressIndicator(),
            )
          ),
        )
      )
      : null
    );

    return new GestureDetector(
      onTapDown: widget.enabled ? _handleTapDown : null,
      onTapUp: widget.enabled ? _handleTapUp : null,
      onTapCancel: widget.enabled ? _handleTapCancel : null,
      onTap: widget.onPressed,

      child: new Stack(
        children: <Widget>[
          textWidget,
          progressIndicator
        ]
      )
    );
  }
}
