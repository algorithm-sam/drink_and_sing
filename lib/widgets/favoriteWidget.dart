import 'package:ant_icons/ant_icons.dart';
import 'package:drinkandsing/constants/fonts.dart';
import 'package:drinkandsing/constants/styles.dart';
import 'package:flutter/material.dart';

class FavWidget extends StatefulWidget {
  final String name, artist;
  final Function removeFav;
  final int id;
  FavWidget({this.name, this.artist, this.id, this.removeFav});

  @override
  _FavWidgetState createState() => _FavWidgetState();
}

class _FavWidgetState extends State<FavWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: EdgeInsets.all(0.2),
      color: widget.id % 2 == 0 ? Colors.grey[850] : primary100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: Icon(
              AntIcons.customer_service_outline,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: '${widget.name} - ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: appbarFont,
                  )),
              TextSpan(
                  text: ' ${widget.artist}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: appbarFont,
                  ))
            ])),
          ),
          GestureDetector(
            onTap: widget.removeFav,
            child: Padding(
              padding: EdgeInsets.only(left: 4.0, right: 4.0),
              child: Icon(
                AntIcons.delete_outline,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }
}
