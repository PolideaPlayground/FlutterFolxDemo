import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:folxdemo/util/folx_colors.dart';
import 'package:folxdemo/folx_widgets/folx_text.dart';
import 'package:folxdemo/util/folx_text_styles.dart';


class FolxButtonLink extends StatefulWidget {
  const FolxButtonLink({
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
  _FolxButtonLink createState() => new _FolxButtonLink();
}

class _FolxButtonLink extends State<FolxButtonLink> {

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
    Color titleEnabledColor = widget.isLightTheme
        ? FolxColors.liver
        : FolxColors.white;
    Color titlePressedColor = widget.isLightTheme
        ? FolxColors.majorelleBlue
        : FolxColors.paleLavender;
    Color titleDisabledColor = widget.isLightTheme
        ? FolxColors.liverA60
        : FolxColors.whiteA50;


    Color titleColor = titleEnabledColor;

    if (!widget.enabled) {
      titleColor = titleDisabledColor;
    } else if (_buttonHeldDown) {
      titleColor = titlePressedColor;
    }

    TextStyle buttonTextStyle = FolxTextStyles.Callout.apply(color: titleColor);

    return new GestureDetector(
        onTapDown: widget.enabled ? _handleTapDown : null,
        onTapUp: widget.enabled ? _handleTapUp : null,
        onTapCancel: widget.enabled ? _handleTapCancel : null,
        onTap: widget.onPressed,

        child: new FolxText(widget.title, buttonTextStyle)
    );
  }
}