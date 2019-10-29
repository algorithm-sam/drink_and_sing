import 'package:ant_icons/ant_icons.dart';
import 'package:dio/dio.dart';
import 'package:drinkandsing/bloc/fav_bloc.dart';
import 'package:drinkandsing/bloc/song_bloc.dart';
import 'package:drinkandsing/constants/fonts.dart';
import 'package:drinkandsing/constants/styles.dart';
import 'package:drinkandsing/data/song.dart';
import 'package:drinkandsing/screens/favorite/favorite.dart';
import 'package:drinkandsing/widgets/drawer.dart';
import 'package:drinkandsing/widgets/followUsDialog.dart';
import 'package:drinkandsing/widgets/songWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tab.dart';

class TabMain extends StatefulWidget {
  static String tag = '/';
  @override
  _TabMainState createState() => _TabMainState();
}

class _TabMainState extends State<TabMain> {
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  List widgetOptions = [
    Home(
      scaffoldState: scaffoldKey,
    ),
    Favorite()
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: DrawerWidget(),
        body: widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: BottomTab(
          doSwitchTab: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedIndex: selectedIndex,
        ));
  }
}

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState;
  Home({this.scaffoldState});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  SongBloc songBloc;
  TabController tabController;
  TextEditingController textController = TextEditingController();
  bool isLoading = true;
  List<Song> searchRes = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    SharedPreferences.getInstance().then((pref) {
      if (pref.getInt('followDialogDismissed') != 1) {
        showDialog(
            context: context,
            builder: (context) {
              return FollowUsDialog();
            });
      }
    });
  }

  searchHelper(songs, String query) {
    songs.map<Song>((song) {


      List<String> individualQuery = query.trim().split(' ');
      String text = song.name + ' ' + song.artist;
      double relevance = 0.0;
      individualQuery.forEach((query){
      if(text.trim().toLowerCase().contains(query.trim().toLowerCase())){
          // searchRes.add(song);
          relevance += 1;
          song.relevance = relevance;
          // print(song.relevance);
          setState((){
            searchRes.add(song);
          });
      }
    });


    }).toList();
    // searchRes.
    List<String> individualQuery = query.trim().split(' ');
    searchRes.retainWhere((song) => song.relevance.toInt()== individualQuery.length);
    // searchRes.where((song){
    //   song.relevance == individualQuery.length;
    // }).toList();
    // searchRes.sort((a,b) => b.relevance.compareTo(a.relevance));
  }

  void doSearch(query) {
    searchRes = [];
    setState(() {
     searchRes = [];
    });
    songBloc = Provider.of<SongBloc>(context);
    switch (tabController.index) {
      case 0:
        searchHelper(songBloc.lebanese, query);
        break;
      case 1:
        searchHelper(songBloc.english, query);
        break;
      case 2:
        searchHelper(songBloc.french, query);
        break;
      case 3:
        searchHelper(songBloc.others, query);
        break;
      default:
    }
  }

  Widget noResult(){
    // check if there is text in the search field;
    // if yes return the no result widget;
    // else return the cupertino activity indicator;
    if(textController.text.trim().length == 0){
            return Center(
              child: CupertinoActivityIndicator(
                radius: 16,
              ),
            );
    }else{
      return Center(
        child: Text(
          'No Result For Search Query',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  List <Widget> buildViews(favBloc){
    List views = ['lebanese','english','french','others'];

      List<Widget> resp = views.map((language){
        if(songBloc.categories[language].length == 0 ){
          return noResult();
        }else{
          return buildList(language, favBloc);
        }
        }).toList();
        setState(() {
          this.isLoading = false;
        });

        return resp;
  }

  TabBarView generateTabView(favBloc){
    return TabBarView(
          controller: tabController,
          children: buildViews(favBloc),
        );
  }

  Widget buildList(String language, favBloc){
    bool isSearching = textController.text.trim().length > 0 ? true : false;
      if (isSearching  && searchRes.length < 1){return noResult();}
      else if (!isSearching && songBloc.categories[language].length < 1 ){return noResult();}
      else {
        // songBloc.setLoadedStatus = true;
       return ListView.builder(

                        key: PageStorageKey(language),
                        itemCount: isSearching ? searchRes.length : songBloc.categories[language].length,
                        itemBuilder: (context, index) {
                          List<Song> songs = isSearching ? searchRes: songBloc.categories[language];
                          return SongWidget(
                            name: songs[index].name,
                            artist: songs[index].artist,
                            id: index,
                            liked: favBloc.favorite.contains(songs[index])
                                ? true
                                : false,
                            addToFav: () {
                              if (favBloc.favorite.contains(songs[index])) {
                                favBloc.removeFav(songs[index]);
                              } else {
                                favBloc.addFav(songs[index]);
                              }
                            },
                          );
                        },
                      );
      }
  }

  @override
  Widget build(BuildContext context) {
    var favBloc = Provider.of<FavBloc>(context);
    songBloc = Provider.of<SongBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: doSearch,
            controller: textController,
            onTap: (){
              textController.text = ' ';
            },
            style: TextStyle(
                color: whiteColor,
                fontSize: 17.0,
                fontFamily: appbarFont,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search for songs...',
                suffixIcon: textController.text.length == 0
                    ? Icon(
                        AntIcons.search_outline,
                        color: Colors.white,
                      )
                    : IconButton(
                        onPressed: () {
                          if (textController.text.length != 0) {
                            setState(() {
                              searchRes = [];
                            });
                            textController.clear();
                          }
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                        )),
                hintStyle: TextStyle(
                    color: whiteColor,
                    fontSize: 17.0,
                    fontFamily: appbarFont,
                    fontWeight: FontWeight.bold)),
          ),
          backgroundColor: appbarColor,
          leading: IconButton(
            onPressed: () {
              widget.scaffoldState.currentState.openDrawer();
            },
            icon: Icon(Icons.account_circle),
          ),
          actions: <Widget>[
            Icon(
              Icons.brightness_1,
              color: this.isLoading == false ? Colors.green : Colors.red,
              size: 16.0,
            ),
          ],
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 2,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'ARABIC',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: baseFont,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Tab(
                child: Text(
                  'ENGLISH',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: baseFont,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Tab(
                child: Text(
                  'FRENCH',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: baseFont,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Tab(
                child: Text(
                  'UNCATEGORIZED',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: baseFont,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        body: generateTabView(favBloc),
        backgroundColor: Colors.grey,
        );
  }
}
