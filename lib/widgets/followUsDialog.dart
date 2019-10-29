import 'package:drinkandsing/constants/fonts.dart';
import 'package:drinkandsing/constants/styles.dart';
import 'package:drinkandsing/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowUsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 4.0,
      title: Text('We\'re social, Follow us on Facebook',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontFamily: appbarFont,
          )),
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: getHeight(context, height: 32),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/banner.jpg',
              width: getWidth(context),
              fit: BoxFit.fitWidth,
              height: 170,
            )
          ],
        ),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pop(context);
            SharedPreferences.getInstance().then((pref) {
              pref.setBool('followDialogDismissed', true);
            });
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
          onTap: () async {
            Navigator.pop(context);
            SharedPreferences.getInstance().then((pref) {
              pref.setInt('followDialogDismissed', 1);
            });
            const url = 'fb://page/1421842984720753';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              await launch(
                  'https://www.facebook.com/Drinkandsinglebanon/?__tn__=%2Cd%2CP-R&eid=ARCvIUyfYwPX8xqrANxZzcw7K8IMIcpNsKLHZhwT41hIIKs4rfcfPqNPbyhLcVn9yAH4N2S6N5tELLKy');
            }
          },
          child: Padding(
              padding: EdgeInsets.only(right: 14.0, bottom: 16.0),
              child: Center(
                child: Text(
                  'OKAY',
                  style: textBoldBlack,
                ),
              )),
        )
      ],
    );
  }
}
