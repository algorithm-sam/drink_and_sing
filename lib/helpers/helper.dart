import 'dart:math';
import 'dart:ui';
import 'package:drinkandsing/constants/styles.dart';
import 'package:flutter/material.dart';

/// return a random integer from range 0 to [max] params
int getRandomInt(int max) {
  return new Random().nextInt(max);
}

/// takes a percentage of the screens width and return a double of current width
double getWidth(context, {width}) {
  if (width == null) return MediaQuery.of(context).size.width;
  return ((width / 100) * MediaQuery.of(context).size.width);
}

/// takes a percentage of the screens height and return a double of screen height.
double getHeight(context, {height}) {
  if (height == null) return MediaQuery.of(context).size.height;
  return ((height / 100) * MediaQuery.of(context).size.height);
}

/// Navigate to a new route by passing a route widget tag
void navigate(context, to, {Object arguments}) {
  Navigator.pushNamed(context, to, arguments: arguments);
}

/// Navigate to a new route by passing a route widget tag
///  and dispose the previous routes
void navigateToDispose(context, to) {
  Navigator.pushNamedAndRemoveUntil(context, to, (_) => false);
}

/// Show snack bar from anywhere in the by passing a global key of type scffold state and the string to be displayed
showSnackBar(GlobalKey<ScaffoldState> _scaffoldState, String content) {
  if (content == null) return;
  if (_scaffoldState.currentState == null) return;
  _scaffoldState.currentState.showSnackBar(SnackBar(
    content: Text(content, style: textBoldWhite),
  ));
}

/// Pop up a dialog box with a button that carry a callback function ,
/// Also you can set the dialog theme color (optional),button icon(optional),title and desc
/// Default Theme color is Red
void showDialogBox({@required context, Function callback}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 4.0,
          contentPadding: const EdgeInsets.all(12.0),
          content: Container(
            height: getHeight(context, height: 27),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.asset(
                      'assets/connect.png',
                      width: 56.0,
                      height: 56.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        'You liked the product and wish to send an enquiry?'),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.maybePop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 14.0, bottom: 16.0),
                child: Center(
                    child: Center(
                  child: Text(
                    'NO',
                    style: textBoldBlack,
                  ),
                )),
              ),
            ),
            InkWell(
              onTap: callback,
              child: Padding(
                  padding: EdgeInsets.only(right: 14.0, bottom: 16.0),
                  child: Center(
                    child: Text(
                      'YES',
                      style: textBoldBlack,
                    ),
                  )),
            )
          ],
        );
      });
}

/// Takes a Widget, optional opacity and optional image String and
/// Returns a new widget with an image as its background set to the passed in opacity
/// Default [Opacity: 0.5]
dynamic customBackground({@required child, opacity: 0.5, String image}) {
  return new Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: ExactAssetImage(image),
        fit: BoxFit.cover,
      ),
    ),
    child: new BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: new Container(
        child: child,
        decoration: new BoxDecoration(color: Colors.white.withOpacity(opacity)),
      ),
    ),
  );
}
