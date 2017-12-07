// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:folxdemo/util/folx_colors.dart';

const Duration _kTransitionDuration = const Duration(milliseconds: 200);
const Curve _kTransitionCurve = Curves.fastOutSlowIn;

// See the InputDecorator.build method, where this is used.
class _InputDecoratorChildGlobalKey extends GlobalObjectKey {
  const _InputDecoratorChildGlobalKey(BuildContext value) : super(value);
}

/// Text and styles used to label an input field.
///
/// The [TextField] and [InputDecorator] classes use [InputDecoration] objects
/// to describe their decoration. (In fact, this class is merely the
/// configuration of an [InputDecorator], which does all the heavy lifting.)
///
/// See also:
///
///  * [TextField], which is a text input widget that uses an
///    [InputDecoration].
///  * [InputDecorator], which is a widget that draws an [InputDecoration]
///    around an arbitrary child widget.
///  * [Decoration] and [DecoratedBox], for drawing arbitrary decorations
///    around other widgets.
@immutable
class InputDecoration {
  /// Creates a bundle of text and styles used to label an input field.
  ///
  /// Sets the [isCollapsed] property to false. To create a decoration that does
  /// not reserve space for [labelText] or [errorText], use
  /// [InputDecoration.collapsed].
  const InputDecoration({
    this.icon,
    this.labelText,
    this.labelStyle,
    this.helperText,
    this.helperStyle,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.errorStyle,
    this.isDense: false,
    this.hideDivider: false,
    this.prefixText,
    this.prefixStyle,
    this.suffixText,
    this.suffixStyle,
  }) : isCollapsed = false;

  /// Creates a decoration that is the same size as the input field.
  ///
  /// This type of input decoration does not include a divider or an icon and
  /// does not reserve space for [labelText] or [errorText].
  ///
  /// Sets the [isCollapsed] property to true.
  const InputDecoration.collapsed({
    @required this.hintText,
    this.hintStyle,
  })
      : icon = null,
        labelText = null,
        labelStyle = null,
        helperText = null,
        helperStyle = null,
        errorText = null,
        errorStyle = null,
        isDense = false,
        isCollapsed = true,
        hideDivider = true,
        prefixText = null,
        prefixStyle = null,
        suffixText = null,
        suffixStyle = null;

  /// An icon to show before the input field.
  ///
  /// The size and color of the icon is configured automatically using an
  /// [IconTheme] and therefore does not need to be explicitly given in the
  /// icon widget.
  ///
  /// See [Icon], [ImageIcon].
  final Widget icon;

  /// Text that describes the input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text my be entered in the input field). When the input field receives
  /// focus (or if the field is non-empty), the label moves above (i.e.,
  /// vertically adjacent to) the input field.
  final String labelText;

  /// The style to use for the [labelText] when the label is above (i.e.,
  /// vertically adjacent to) the input field.
  ///
  /// When the [labelText] is on top of the input field, the text uses the
  /// [hintStyle] instead.
  ///
  /// If null, defaults of a value derived from the base [TextStyle] for the
  /// input field and the current [Theme].
  final TextStyle labelStyle;

  /// Text that provides context about the field’s value, such as how the value
  /// will be used.
  ///
  /// If non-null, the text is displayed below the input field, in the same
  /// location as [errorText]. If a non-null [errorText] value is specified then
  /// the helper text is not shown.
  final String helperText;

  /// The style to use for the [helperText].
  final TextStyle helperStyle;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// Displayed on top of the input field (i.e., at the same location on the
  /// screen where text my be entered in the input field) when the input field
  /// is empty and either (a) [labelText] is null or (b) the input field has
  /// focus.
  final String hintText;

  /// The style to use for the [hintText].
  ///
  /// Also used for the [labelText] when the [labelText] is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text my be entered in the input field).
  ///
  /// If null, defaults of a value derived from the base [TextStyle] for the
  /// input field and the current [Theme].
  final TextStyle hintStyle;

  /// Text that appears below the input field.
  ///
  /// If non-null, the divider that appears below the input field is red.
  final String errorText;

  /// The style to use for the [errorText].
  ///
  /// If null, defaults of a value derived from the base [TextStyle] for the
  /// input field and the current [Theme].
  final TextStyle errorStyle;

  /// Whether the input field is part of a dense form (i.e., uses less vertical
  /// space).
  ///
  /// Defaults to false.
  final bool isDense;

  /// Whether the decoration is the same size as the input field.
  ///
  /// A collapsed decoration cannot have [labelText], [errorText], an [icon], or
  /// a divider because those elements require extra space.
  ///
  /// To create a collapsed input decoration, use [InputDecoration..collapsed].
  final bool isCollapsed;

  /// Whether to hide the divider below the input field and above the error text.
  ///
  /// Defaults to false.
  final bool hideDivider;

  /// Optional text prefix to place on the line before the input.
  ///
  /// Uses the [prefixStyle]. Uses [hintStyle] if [prefixStyle] isn't
  /// specified. Prefix is not returned as part of the input.
  final String prefixText;

  /// The style to use for the [prefixText].
  ///
  /// If null, defaults to the [hintStyle].
  final TextStyle prefixStyle;

  /// Optional text suffix to place on the line after the input.
  ///
  /// Uses the [suffixStyle]. Uses [hintStyle] if [suffixStyle] isn't
  /// specified. Suffix is not returned as part of the input.
  final String suffixText;

  /// The style to use for the [suffixText].
  ///
  /// If null, defaults to the [hintStyle].
  final TextStyle suffixStyle;

  /// Creates a copy of this input decoration but with the given fields replaced
  /// with the new values.
  ///
  /// Always sets [isCollapsed] to false.
  InputDecoration copyWith({
    Widget icon,
    String labelText,
    TextStyle labelStyle,
    String helperText,
    TextStyle helperStyle,
    String hintText,
    TextStyle hintStyle,
    String errorText,
    TextStyle errorStyle,
    bool isDense,
    bool hideDivider,
    String prefixText,
    TextStyle prefixStyle,
    String suffixText,
    TextStyle suffixStyle,
  }) {
    return new InputDecoration(
      icon: icon ?? this.icon,
      labelText: labelText ?? this.labelText,
      labelStyle: labelStyle ?? this.labelStyle,
      helperText: helperText ?? this.helperText,
      helperStyle: helperStyle ?? this.helperStyle,
      hintText: hintText ?? this.hintText,
      hintStyle: hintStyle ?? this.hintStyle,
      errorText: errorText ?? this.errorText,
      errorStyle: errorStyle ?? this.errorStyle,
      isDense: isDense ?? this.isDense,
      hideDivider: hideDivider ?? this.hideDivider,
      prefixText: prefixText ?? this.prefixText,
      prefixStyle: prefixStyle ?? this.prefixStyle,
      suffixText: suffixText ?? this.suffixText,
      suffixStyle: suffixStyle ?? this.suffixStyle,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other))
      return true;
    if (other.runtimeType != runtimeType)
      return false;
    final InputDecoration typedOther = other;
    return typedOther.icon == icon
        && typedOther.labelText == labelText
        && typedOther.labelStyle == labelStyle
        && typedOther.helperText == helperText
        && typedOther.helperStyle == helperStyle
        && typedOther.hintText == hintText
        && typedOther.hintStyle == hintStyle
        && typedOther.errorText == errorText
        && typedOther.errorStyle == errorStyle
        && typedOther.isDense == isDense
        && typedOther.isCollapsed == isCollapsed
        && typedOther.hideDivider == hideDivider
        && typedOther.prefixText == prefixText
        && typedOther.prefixStyle == prefixStyle
        && typedOther.suffixText == suffixText
        && typedOther.suffixStyle == suffixStyle;
  }

  @override
  int get hashCode {
    return hashValues(
      icon,
      labelText,
      labelStyle,
      helperText,
      helperStyle,
      hintText,
      hintStyle,
      errorText,
      errorStyle,
      isDense,
      isCollapsed,
      hideDivider,
      prefixText,
      prefixStyle,
      suffixText,
      suffixStyle,
    );
  }

  @override
  String toString() {
    final List<String> description = <String>[];
    if (icon != null)
      description.add('icon: $icon');
    if (labelText != null)
      description.add('labelText: "$labelText"');
    if (helperText != null)
      description.add('helperText: "$helperText"');
    if (hintText != null)
      description.add('hintText: "$hintText"');
    if (errorText != null)
      description.add('errorText: "$errorText"');
    if (isDense)
      description.add('isDense: $isDense');
    if (isCollapsed)
      description.add('isCollapsed: $isCollapsed');
    if (hideDivider)
      description.add('hideDivider: $hideDivider');
    if (prefixText != null)
      description.add('prefixText: $prefixText');
    if (prefixStyle != null)
      description.add('prefixStyle: $prefixStyle');
    if (suffixText != null)
      description.add('suffixText: $suffixText');
    if (suffixStyle != null)
      description.add('suffixStyle: $suffixStyle');
    return 'InputDecoration(${description.join(', ')})';
  }
}

/// Displays the visual elements of a Material Design text field around an
/// arbitrary widget.
///
/// Use [InputDecorator] to create widgets that look and behave like a
/// [TextField] but can be used to input information other than text.
///
/// The configuration of this widget is primarily provided in the form of an
/// [InputDecoration] object.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
///  * [TextField], which uses an [InputDecorator] to draw labels and other
///    visual elements around a text entry widget.
///  * [Decoration] and [DecoratedBox], for drawing arbitrary decorations
///    around other widgets.
class InputDecorator extends StatelessWidget {
  /// Creates a widget that displayes labels and other visual elements similar
  /// to a [TextField].
  ///
  /// The [isFocused] and [isEmpty] arguments must not be null.
  const InputDecorator({
    Key key,
    @required this.decoration,
    this.baseStyle,
    this.textAlign,
    this.isFocused: false,
    this.isEmpty: false,
    this.child,
  })
      : assert(isFocused != null),
        assert(isEmpty != null),
        super(key: key);

  /// The text and styles to use when decorating the child.
  final InputDecoration decoration;

  /// The style on which to base the label, hint, and error styles if the
  /// [decoration] does not provide explicit styles.
  ///
  /// If null, defaults to a text style from the current [Theme].
  final TextStyle baseStyle;

  /// How the text in the decoration should be aligned horizontally.
  final TextAlign textAlign;

  /// Whether the input field has focus.
  ///
  /// Determines the position of the label text and the color of the divider.
  ///
  /// Defaults to false.
  final bool isFocused;

  /// Whether the input field is empty.
  ///
  /// Determines the position of the label text and whether to display the hint
  /// text.
  ///
  /// Defaults to false.
  final bool isEmpty;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(
        new DiagnosticsProperty<InputDecoration>('decoration', decoration));
    description.add(new EnumProperty<TextStyle>('baseStyle', baseStyle));
    description.add(new DiagnosticsProperty<bool>('isFocused', isFocused));
    description.add(new DiagnosticsProperty<bool>('isEmpty', isEmpty));
  }

  Color _getActiveColor(ThemeData themeData) {
    if (isFocused) {
      return FolxColors.majorelleBlue;
    }
    return FolxColors.liverA60;
  }

  Widget _buildContent(Color borderColor, double topPadding, bool isDense,
      Widget inputChild) {
    final double bottomPadding = isDense ? 8.0 : 1.0;
    const double bottomBorder = 2.0;
    final double bottomHeight = isDense ? 14.0 : 18.0;

    final EdgeInsets padding = new EdgeInsets.only(
        top: topPadding, bottom: bottomPadding);
    final EdgeInsets margin = new EdgeInsets.only(
        bottom: bottomHeight - (bottomPadding + bottomBorder));

    if (decoration.hideDivider) {
      return new Container(
        margin: margin + const EdgeInsets.only(bottom: bottomBorder),
        padding: padding,
        child: inputChild,
      );
    }

    return new AnimatedContainer(
      margin: margin,
      padding: padding,
      duration: _kTransitionDuration,
      curve: _kTransitionCurve,
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            color: borderColor,
            width: bottomBorder,
          ),
        ),
      ),
      child: inputChild,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData themeData = Theme.of(context);

    final bool isDense = decoration.isDense;
    final bool isCollapsed = decoration.isCollapsed;
    assert(!isDense || !isCollapsed);

    final String labelText = decoration.labelText;
    final String helperText = decoration.helperText;
    final String hintText = decoration.hintText;
    final String errorText = decoration.errorText;

    final TextStyle baseStyle = this.baseStyle ?? themeData.textTheme.subhead;
    final TextStyle hintStyle = decoration.hintStyle ??
        baseStyle.copyWith(color: themeData.hintColor);

    final Color activeColor = _getActiveColor(themeData);

    double topPadding = 0.0; //: (isDense ? 2.0 : 6.0);

    final List<Widget> stackChildren = <Widget>[];

    // If we're not focused, there's no value, and labelText was provided,
    // then the label appears where the hint would. And we will not show
    // the hintText.
    final bool hasInlineLabel = false; //!isFocused && labelText != null && isEmpty;

    if (labelText != null) {
      assert(!isCollapsed);
      final TextStyle labelStyle = hasInlineLabel ?
      hintStyle : (decoration.labelStyle ??
          themeData.textTheme.caption.copyWith(color: activeColor));

      final double topPaddingIncrement = themeData.textTheme.caption.fontSize +
          (isDense ? 4.0 : 8.0);
      double top = topPadding;
      if (hasInlineLabel)
        top += topPaddingIncrement + baseStyle.fontSize - labelStyle.fontSize;

      stackChildren.add(
        new Positioned(
          top: top,
          child: new _AnimatedLabel(
            text: labelText,
            style: labelStyle,
            duration: _kTransitionDuration,
            curve: _kTransitionCurve,
          ),
        ),
      );

      topPadding += topPaddingIncrement;
    }

    if (hintText != null) {
      stackChildren.add(
        new Positioned(
          left: 0.0,
          right: 0.0,
          top: topPadding + baseStyle.fontSize - hintStyle.fontSize,
          child: new AnimatedOpacity(
            opacity: (isEmpty && !hasInlineLabel) ? 1.0 : 0.0,
            duration: _kTransitionDuration,
            curve: _kTransitionCurve,
            child: new Text(
              hintText,
              style: hintStyle,
              overflow: TextOverflow.ellipsis,
              textAlign: textAlign,
            ),
          ),
        ),
      );
    }

    Widget inputChild = new KeyedSubtree(
      // It's important that we maintain the state of our child subtree, as it
      // may be stateful (e.g. containing text selections). Since our build
      // function risks changing the depth of the tree, we preserve the subtree
      // using global keys.
      // GlobalObjectKey(context) will always be the same whenever we are built.
      // Additionally, we use a subclass of GlobalObjectKey to avoid clashes
      // with anyone else using our BuildContext as their global object key
      // value.
      key: new _InputDecoratorChildGlobalKey(context),
      child: child,
    );

    if (!hasInlineLabel && (!isEmpty || hintText == null) &&
        (decoration?.prefixText != null || decoration?.suffixText != null)) {
      final List<Widget> rowContents = <Widget>[];
      if (decoration.prefixText != null) {
        rowContents.add(
            new Text(decoration.prefixText,
                style: decoration.prefixStyle ?? hintStyle)
        );
      }
      rowContents.add(new Expanded(child: inputChild));
      if (decoration.suffixText != null) {
        rowContents.add(
            new Text(decoration.suffixText,
                style: decoration.suffixStyle ?? hintStyle)
        );
      }
      inputChild = new Row(children: rowContents);
    }

    if (isCollapsed) {
      stackChildren.add(inputChild);
    } else {
      final Color borderColor = errorText == null ? activeColor : FolxColors
          .coquelicot;
      stackChildren.add(
          _buildContent(borderColor, topPadding, isDense, inputChild));
    }

    if (!isDense && (errorText != null || helperText != null)) {
      assert(!isCollapsed);
      final TextStyle captionStyle = themeData.textTheme.caption;
      final TextStyle subtextStyle = errorText != null
          ? decoration.errorStyle ??
          captionStyle.copyWith(color: themeData.errorColor)
          : decoration.helperStyle ??
          captionStyle.copyWith(color: themeData.hintColor);

      if (Theme
          .of(context)
          .platform == TargetPlatform.iOS) {
        stackChildren.add(new Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child:
          new Align(
            alignment: Alignment.center,
            child: new Text(
              errorText ?? helperText,
              style: subtextStyle,
              textAlign: textAlign,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ));
      } else {
        stackChildren.add(new Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: new SizedBox(
            height: 14.0,
            child: new Row(
                children: <Widget>[
                  new Text(
                    errorText ?? helperText,
                    style: subtextStyle,
                    textAlign: textAlign,
                    overflow: TextOverflow.ellipsis,
                  ),
                  new Expanded(
                      child: new Align(alignment: Alignment.bottomRight,
                          child: new Image.asset('images/ic_warning.png')))
                ]
            ),
          ),
        ));
      }
    }

    final Widget stack = new Stack(
        fit: StackFit.passthrough,
        children: stackChildren
    );

    if (decoration.icon != null) {
      assert(!isCollapsed);
      final double iconSize = isDense ? 18.0 : 24.0;
      final double iconTop = topPadding + (baseStyle.fontSize - iconSize) / 2.0;
      return new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(top: iconTop),
            width: isDense ? 40.0 : 48.0,
            child: IconTheme.merge(
              data: new IconThemeData(
                color: isFocused ? activeColor : Colors.black45,
                size: isDense ? 18.0 : 24.0,
              ),
              child: decoration.icon,
            ),
          ),
          new Expanded(child: stack),
        ],
      );
    } else {
      return new ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.INFINITY),
          child: stack
      );
    }
  }
}

// Smoothly animate the label of an InputDecorator as the label
// transitions between inline and caption.
class _AnimatedLabel extends ImplicitlyAnimatedWidget {
  const _AnimatedLabel({
    Key key,
    this.text,
    @required this.style,
    Curve curve: Curves.linear,
    @required Duration duration,
  })
      : assert(style != null),
        super(key: key, curve: curve, duration: duration);

  final String text;
  final TextStyle style;

  @override
  _AnimatedLabelState createState() => new _AnimatedLabelState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    style?.debugFillProperties(description);
  }
}

class _AnimatedLabelState extends AnimatedWidgetBaseState<_AnimatedLabel> {
  TextStyleTween _style;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _style = visitor(
        _style, widget.style, (dynamic value) =>
    new TextStyleTween(
        begin: value));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = _style.evaluate(animation);
    double scale = 1.0;
    if (style.fontSize != widget.style.fontSize) {
      // While the fontSize is transitioning, use a scaled Transform as a
      // fraction of the original fontSize. That way we get a smooth scaling
      // effect with no snapping between discrete font sizes.
      scale = style.fontSize / widget.style.fontSize;
      style = style.copyWith(fontSize: widget.style.fontSize);
    }

    return new Transform(
      transform: new Matrix4.identity()
        ..scale(scale),
      child: new Text(
        widget.text,
        style: style,
      ),
    );
  }
}


class TextFormField extends FormField<String> {
  /// Creates a [FormField] that contains a [TextField].
  ///
  /// When a [controller] is specified, it can be used to control the text
  /// being edited. Its content will be overwritten by [initialValue] (which
  /// defaults to the empty string) on creation and when [reset] is called.
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  TextFormField({
    Key key,
    this.controller,
    String initialValue: '',
    FocusNode focusNode,
    InputDecoration decoration: const InputDecoration(),
    TextInputType keyboardType: TextInputType.text,
    TextStyle style,
    bool autofocus: false,
    bool obscureText: false,
    bool autocorrect: true,
    int maxLines: 1,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
  })
      : assert(initialValue != null),
        assert(keyboardType != null),
        assert(autofocus != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(maxLines == null || maxLines > 0),
        super(
        key: key,
        initialValue: initialValue,
        onSaved: onSaved,
        validator: validator,
        builder: (FormFieldState<String> field) {
          final _TextFormFieldState state = field;
          return new TextField(
            controller: state._effectiveController,
            focusNode: focusNode,
            decoration: decoration.copyWith(errorText: field.errorText),
            keyboardType: keyboardType,
            style: style,
            autofocus: autofocus,
            obscureText: obscureText,
            autocorrect: autocorrect,
            maxLines: maxLines,
            onChanged: field.onChanged,
            inputFormatters: inputFormatters,
          );
        },
      );

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController controller;

  @override
  _TextFormFieldState createState() => new _TextFormFieldState();
}

class _TextFormFieldState extends FormFieldState<String> {
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  TextFormField get widget => super.widget;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = new TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.text = widget.initialValue;
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(TextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
        new TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(widget.controller.text);
        if (oldWidget.controller == null)
          _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value)
      onChanged(_effectiveController.text);
  }
}


class TextField extends StatefulWidget {
  /// Creates a Material Design text field.
  ///
  /// If [decoration] is non-null (which is the default), the text field requires
  /// one of its ancestors to be a [Material] widget.
  ///
  /// To remove the decoration entirely (including the extra padding introduced
  /// by the decoration to save space for the labels), set the [decoration] to
  /// null.
  ///
  /// The [maxLines] property can be set to null to remove the restriction on
  /// the number of lines. By default, it is one, meaning this is a single-line
  /// text field. [maxLines] must not be zero. If [maxLines] is not one, then
  /// [keyboardType] is ignored, and the [TextInputType.multiline] keyboard type
  /// is used.
  ///
  /// The [keyboardType], [textAlign], [autofocus], [obscureText], and
  /// [autocorrect] arguments must not be null.
  const TextField({
    Key key,
    this.controller,
    this.focusNode,
    this.decoration: const InputDecoration(),
    TextInputType keyboardType: TextInputType.text,
    this.style,
    this.textAlign: TextAlign.start,
    this.autofocus: false,
    this.obscureText: false,
    this.autocorrect: true,
    this.maxLines: 1,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
  })
      : assert(keyboardType != null),
        assert(textAlign != null),
        assert(autofocus != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(maxLines == null || maxLines > 0),
        keyboardType = maxLines == 1 ? keyboardType : TextInputType.multiline,
        super(key: key);

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController controller;

  /// Controls whether this widget has keyboard focus.
  ///
  /// If null, this widget will create its own [FocusNode].
  final FocusNode focusNode;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Set this field to null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// The type of keyboard to use for editing the text.
  ///
  /// Defaults to [TextInputType.text]. Must not be null. If
  /// [maxLines] is not one, then [keyboardType] is ignored, and the
  /// [TextInputType.multiline] keyboard type is used.
  final TextInputType keyboardType;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to a text style from the current [Theme].
  final TextStyle style;

  /// How the text being edited should be aligned horizontally.
  ///
  /// Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// Whether this text field should focus itself if nothing else is already
  /// focused.
  ///
  /// If true, the keyboard will open as soon as this text field obtains focus.
  /// Otherwise, the keyboard is only shown after the user taps the text field.
  ///
  /// Defaults to false. Cannot be null.
  // See https://github.com/flutter/flutter/issues/7035 for the rationale for this
  // keyboard behavior.
  final bool autofocus;

  /// Whether to hide the text being edited (e.g., for passwords).
  ///
  /// When this is set to true, all the characters in the text field are
  /// replaced by U+2022 BULLET characters (•).
  ///
  /// Defaults to false. Cannot be null.
  final bool obscureText;

  /// Whether to enable autocorrection.
  ///
  /// Defaults to true. Cannot be null.
  final bool autocorrect;

  /// The maximum number of lines for the text to span, wrapping if necessary.
  ///
  /// If this is 1 (the default), the text will not wrap, but will scroll
  /// horizontally instead.
  ///
  /// If this is null, there is no limit to the number of lines. If it is not
  /// null, the value must be greater than zero.
  final int maxLines;

  /// Called when the text being edited changes.
  final ValueChanged<String> onChanged;

  /// Called when the user indicates that they are done editing the text in the
  /// field.
  final ValueChanged<String> onSubmitted;

  /// Optional input validation and formatting overrides.
  ///
  /// Formatters are run in the provided order when the text input changes.
  final List<TextInputFormatter> inputFormatters;

  @override
  _TextFieldState createState() => new _TextFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(new DiagnosticsProperty<TextEditingController>(
        'controller', controller, defaultValue: null));
    description.add(new DiagnosticsProperty<FocusNode>(
        'focusNode', focusNode, defaultValue: null));
    description.add(
        new DiagnosticsProperty<InputDecoration>('decoration', decoration));
    description.add(new EnumProperty<TextInputType>(
        'keyboardType', keyboardType, defaultValue: TextInputType.text));
    description.add(
        new DiagnosticsProperty<TextStyle>('style', style, defaultValue: null));
    description.add(new DiagnosticsProperty<bool>(
        'autofocus', autofocus, defaultValue: false));
    description.add(new DiagnosticsProperty<bool>(
        'obscureText', obscureText, defaultValue: false));
    description.add(new DiagnosticsProperty<bool>(
        'autocorrect', autocorrect, defaultValue: false));
    description.add(new IntProperty('maxLines', maxLines, defaultValue: 1));
  }
}

class _TextFieldState extends State<TextField> {
  final GlobalKey<EditableTextState> _editableTextKey = new GlobalKey<
      EditableTextState>();

  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  FocusNode _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= new FocusNode());

  @override
  void initState() {
    super.initState();
    if (widget.controller == null)
      _controller = new TextEditingController();
  }

  @override
  void didUpdateWidget(TextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null)
      _controller =
      new TextEditingController.fromValue(oldWidget.controller.value);
    else if (widget.controller != null && oldWidget.controller == null)
      _controller = null;
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  void _requestKeyboard() {
    _editableTextKey.currentState?.requestKeyboard();
  }

  void _onSelectionChanged(BuildContext context, bool longPress) {
    if (longPress)
      Feedback.forLongPress(context);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle style = widget.style ?? themeData.textTheme.subhead;
    final TextEditingController controller = _effectiveController;
    final FocusNode focusNode = _effectiveFocusNode;

    Widget child = new RepaintBoundary(
      child: new EditableText(
        key: _editableTextKey,
        controller: controller,
        focusNode: focusNode,
        keyboardType: widget.keyboardType,
        style: style,
        textAlign: widget.textAlign,
        autofocus: widget.autofocus,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        maxLines: widget.maxLines,
        cursorColor: FolxColors.liver,
        selectionColor: FolxColors.liverA60,
        selectionControls: themeData.platform == TargetPlatform.iOS
            ? cupertinoTextSelectionControls
            : materialTextSelectionControls,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        onSelectionChanged: (TextSelection _, bool longPress) =>
            _onSelectionChanged(context, longPress),
        inputFormatters: widget.inputFormatters,
      ),
    );

    if (widget.decoration != null) {
      child = new AnimatedBuilder(
        animation: new Listenable.merge(<Listenable>[ focusNode, controller]),
        builder: (BuildContext context, Widget child) {
          return new InputDecorator(
            decoration: widget.decoration,
            baseStyle: widget.style,
            textAlign: widget.textAlign,
            isFocused: focusNode.hasFocus,
            isEmpty: controller.value.text.isEmpty,
            child: child,
          );
        },
        child: child,
      );
    }

    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _requestKeyboard,
      child: child,
    );
  }
}