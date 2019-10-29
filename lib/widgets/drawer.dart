import 'package:drinkandsing/constants/fonts.dart';
import 'package:drinkandsing/constants/styles.dart';
import 'package:drinkandsing/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'drawerItems.dart';

class DrawerWidget extends StatefulWidget {
  final String activeScreenName;
  DrawerWidget({this.activeScreenName});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    // var appState = Provider.of<AuthBloc>(context);
    return Container(
        width: getWidth(context, width: 90),
        color: Colors.white,
        child: Column(children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: primarylight),
            margin: EdgeInsets.all(0.0),
            accountName: new Text(
              'Drink And Sing App',
              style: headingWhite,
            ),
            accountEmail: new Text('2019 swift solutions | +961 71601604',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: textFont,
                )),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new ClipRRect(
                  borderRadius: new BorderRadius.circular(100.0),
                  child: GestureDetector(
                      onTap: () {},
                      child: new Container(
                        height: 80.0,
                        width: 80.0,
                        color: primaryColor,
                      ))),
            ),
            onDetailsPressed: () {},
          ),
          MediaQuery.removePadding(
              context: context,
              // DrawerHeader consumes top MediaQuery padding.
              removeTop: true,
              child: new Expanded(
                  child: new ListView(
                      children: drawerItems.map((item) {
                return new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        switch (item.id) {
                          case 0:
                            showAboutUsDialog(context);
                            break;
                          case 1:
                            followUsOnFB();
                            break;
                          case 2:
                            contactUs();
                            break;
                          case 3:
                            share();
                            break;
                          default:
                            return null;
                        }
                      },
                      child: new Container(
                        height: 60.0,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              flex: 1,
                              child: Icon(
                                item.icon,
                                color: blackColor,
                              ),
                            ),
                            new Expanded(
                              flex: 3,
                              child: new Text(
                                item.name,
                                style: headingBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }).toList())))
        ]));
  }
}

void showAboutUsDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 4.0,
          contentPadding: const EdgeInsets.all(12.0),
          title: Text('ABOUT US', style: headingBlack18Bold),
          content: Container(
            height: getHeight(context, height: 32),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        'Drink and Sing karaoke pubs serving karaoke and drinks every night. Locations are Monnot, Gemmeyze, Broumana, Chataura, Antelias, Zouk, Jeita, Jbeil, Zahle and Batroun.',
                        style: textBoldBlack),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 14.0, bottom: 16.0),
                  child: Center(
                    child: Text(
                      'OK',
                      style: textBoldBlack,
                    ),
                  )),
            )
          ],
        );
      });
}

void followUsOnFB() async {
  const url = 'fb://page/1421842984720753';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    await launch(
        'https://www.facebook.com/Drinkandsinglebanon/?__tn__=%2Cd%2CP-R&eid=ARCvIUyfYwPX8xqrANxZzcw7K8IMIcpNsKLHZhwT41hIIKs4rfcfPqNPbyhLcVn9yAH4N2S6N5tELLKy');
  }
}

void contactUs() async {
  const url = 'mailto:lebanesekaraoke@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  }
}

void share() {
  Share.share('Drink And Sing',
      subject:
          'Hey Friend! Checkout this awesome karaoke App https://link.to.playstore.com');
}
