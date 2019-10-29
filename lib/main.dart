import 'package:drinkandsing/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/song_bloc.dart';
import 'bloc/fav_bloc.dart';
import 'constants/styles.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => SongBloc(),
        ),
        ChangeNotifierProvider(
          builder: (context) => FavBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Drink And Sing',
        color: primaryColor,
        routes: {TabMain.tag: (context) => TabMain()},
        initialRoute: TabMain.tag,
      ),
    );
  }
}
