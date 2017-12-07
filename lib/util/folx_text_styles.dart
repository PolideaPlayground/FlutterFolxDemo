import 'package:flutter/widgets.dart';
import 'package:folxdemo/util/folx_colors.dart';


class FolxTextStyles {
  FolxTextStyles._();

  static final TextStyle Title = new TextStyle(
      color: FolxColors.white,
      fontSize: 42.0,
      decoration: TextDecoration.none,
      height: 1.2);

  static final TextStyle Title2 = new TextStyle(
      color: FolxColors.liver,
      fontSize: 28.0,
      decoration: TextDecoration.none);

  static final TextStyle Body = new TextStyle(
      color: FolxColors.liver,
      fontSize: 16.0,
      decoration: TextDecoration.none);

  static final TextStyle BodyStrong = new TextStyle(
      color: FolxColors.white,
      fontSize: 16.0,
      decoration: TextDecoration.none);

  static final TextStyle Callout = new TextStyle(
      color: FolxColors.white,
      fontSize: 14.0,
      decoration: TextDecoration.none
  );

  static final TextStyle Footnote = new TextStyle(
      color: FolxColors.liver,
      fontSize: 12.0,
      decoration: TextDecoration.none);
}