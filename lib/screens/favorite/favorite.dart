import 'package:ant_icons/ant_icons.dart';
import 'package:dio/dio.dart';
import 'package:drinkandsing/bloc/fav_bloc.dart';
import 'package:drinkandsing/constants/fonts.dart';
import 'package:drinkandsing/constants/styles.dart';
import 'package:drinkandsing/widgets/favoriteWidget.dart';
import 'package:drinkandsing/widgets/songWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  static String tag = '/favorite';
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  AppBar appBar = AppBar(
    title: Text('Favorite Songs',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          fontFamily: appbarFont,
        )),
    backgroundColor: appbarColor,
  );
  @override
  Widget build(BuildContext context) {
    var favBloc = Provider.of<FavBloc>(context);

    return Scaffold(
        appBar: appBar,
        body: favBloc.favorite.length == 0
            ? favBloc.isLoading
                ? Center(
                    child: CupertinoActivityIndicator(
                      radius: 16,
                    ),
                  )
                : Center(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Favorite collection is empty, Go to songs and start adding your favorites!',
                          style: textBoldBlack,
                          textAlign: TextAlign.center,
                        )))
            : ListView.builder(
                itemCount: favBloc.favorite.length,
                itemBuilder: (context, index) {
                  return FavWidget(
                    name: favBloc.favorite[index].name,
                    artist: favBloc.favorite[index].artist,
                    id: index,
                    removeFav: () {
                      favBloc.removeFav(favBloc.favorite[index]);
                    },
                  );
                },
              ));
  }
}
