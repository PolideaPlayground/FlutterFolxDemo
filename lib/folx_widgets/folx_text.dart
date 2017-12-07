import 'package:flutter/material.dart';


class FolxText extends RichText {

  // Matches markdown bold like: "Normal **bolded**"
  static final RegExp _exp = new RegExp(r"\*\*(.*?)\*\*");

  FolxText(String text, TextStyle style)
      : super(text: handleMarkdown(text, style));

  static TextSpan handleMarkdown(String text, TextStyle style) {
    String strippedText = text.replaceAll("*", "");

    Match regexMatch = _exp.firstMatch(text);

    var spans = <TextSpan>[];

    if (regexMatch != null && regexMatch.groupCount >= 1) {
      String matchedText = regexMatch.group(1);
      String beforeMatch = strippedText.substring(0, regexMatch.start);
      String afterMatch = text.substring(regexMatch.end, text.length);

      spans.add(new TextSpan(text: beforeMatch, style: style));
      spans.add(new TextSpan(text: matchedText, style: new TextStyle(
          color: style.color,
          fontSize: style.fontSize,
          decoration: style.decoration
      )));
      spans.add(new TextSpan(text: afterMatch, style: style));
    } else {
      spans.add(new TextSpan(text: text, style: style));
    }

    return new TextSpan(
        children: spans
    );
  }
}