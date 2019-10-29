import 'package:ant_icons/ant_icons.dart';
import 'package:drinkandsing/constants/fonts.dart';
import 'package:drinkandsing/constants/styles.dart';
import 'package:flutter/material.dart';

class SongWidget extends StatefulWidget {
  final String name, artist;
  final bool liked;
  final Function addToFav;
  final int id;
  SongWidget(
      {this.name, this.artist, this.liked = false, this.id, this.addToFav});

  @override
  _SongWidgetState createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: EdgeInsets.all(0.2),
      color: widget.id % 2 == 0 ? Colors.grey[850] : primary100,
      child: InkWell(
        onTap: widget.addToFav,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: widget.addToFav,
              child: Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: widget.liked
                    ? Icon(
                        AntIcons.star,
                        color: Colors.orangeAccent,
                      )
                    : Icon(
                        AntIcons.star_outline,
                        color: Colors.white,
                      ),
              ),
            ),
            SizedBox(
              width: 4.0,
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
            )
          ],
        ),
      ),
    );
  }
}
