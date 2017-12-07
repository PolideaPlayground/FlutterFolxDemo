import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folxdemo/folx_widgets/folx_button.dart';
import 'package:folxdemo/folx_widgets/folx_button_link.dart';
import 'package:folxdemo/routes.dart';
import 'package:folxdemo/util/folx_colors.dart';
import 'package:folxdemo/util/folx_text_styles.dart';

class TutorialPage {
  const TutorialPage(this.title);

  final String title;
}

const List<TutorialPage> pages = const <TutorialPage>[
  const TutorialPage("Folx\nPierwszy\noperator\nw aplikacji"),
  const TutorialPage("Internet,\nrozmowy\ni SMS-y\nzawsze\nza 29,99 zł"),
  const TutorialPage("Karta SIM\nprzyjedzie\nz Uberem\nnawet w 15 min")
];

class TutorialWidget extends StatefulWidget {

  @override
  _TutorialWidgetState createState() => new _TutorialWidgetState();
}

class _TutorialWidgetState extends State<TutorialWidget> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: pages.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _startClicked() {
    Navigator.of(context).pushReplacement(FolxRoutes.referralRoute());
  }

  void _loginClicked() {
    // ignore
  }

  @override
  Widget build(BuildContext context) {
    double toolbarHeight = Theme
      .of(context)
      .platform == TargetPlatform.iOS ? 44.0 : kToolbarHeight;

    BoxDecoration folxBackgroundDecoration = new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage("images/background.png"),
        fit: BoxFit.cover
      )
    );

    Widget emptyAppBar = new PreferredSize(
      preferredSize: new Size.fromHeight(toolbarHeight),
      child: new Container()
    );

    Widget tabBar = new TabBarView(
      controller: _tabController,

      children: pages.map((TutorialPage page) {
        return new TutorialPageWidget(page: page);
      }).toList(),
    );

    Widget indicator = new Container(
      margin: const EdgeInsets.only(bottom: 32.0),

      child: new Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.white),

        child: new TabPageSelector(controller: _tabController, indicatorSize: 8.0)
      )
    );

    Widget margin =  new Expanded(
      flex: 8,
      child: new Container(constraints: new BoxConstraints(minWidth: 8.0))
    );

    Widget button = new Expanded(
      flex: 84,

      child: new FolxButton(
        title: "Start",
        isLightTheme: false,
        onPressed: _startClicked),
    );

    Widget textButton = new SizedBox.fromSize(
      size: new Size.fromHeight(80.0),

      child: new Center(
        child: new FolxButtonLink(
          title: "Masz już konto? **Zaloguj się**",
          isLightTheme: false,
          onPressed: _loginClicked
        )
      )
    );

    return new Container(
      decoration: folxBackgroundDecoration,

      child: new Scaffold(
        backgroundColor: FolxColors.transparent,
        appBar: emptyAppBar,
        body: tabBar,

        bottomNavigationBar:
        new Column(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            indicator,

            new Row(
              children: <Widget>[
                margin,
                button,
                margin
              ]
            ),

            textButton
          ]
        )
      )
    );
  }
}


class TutorialPageWidget extends StatelessWidget {
  const TutorialPageWidget({ Key key, this.page }) : super(key: key);

  final TutorialPage page;

  @override
  Widget build(BuildContext context) {

    Widget marginTop =  new Expanded(
      flex: 1,
      child: new Container(constraints: new BoxConstraints(minHeight: 16.0))
    );

    Widget marginBottom =  new Expanded(
      flex: 2,
      child: new Container(constraints: new BoxConstraints(minHeight: 32.0))
    );

    Widget horizontalMargin = new Expanded(
      flex: 8,
      child: new Container(constraints: new BoxConstraints(minWidth: 8.0))
    );

    Widget text = new Expanded(
      flex: 84,

      child: new Text(page.title, style: FolxTextStyles.Title),
    );

    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        marginTop,

        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            horizontalMargin,
            text,
            horizontalMargin,
          ]
        ),

        marginBottom
      ]
    );
  }
}