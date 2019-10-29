import 'package:dio/dio.dart';
import 'package:drinkandsing/data/song.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class SongBloc with ChangeNotifier {
  SongBloc() {
    this.setLoadedStatus=false;
    this.getSong('lebanese');
    this.getSong('english');
    this.getSong('french');
    this.getSong('others');
    // this.setLoadedStatus = true;
  }
  LocalStorage localStorage = new LocalStorage('songs');
  bool _isLoaded = false;
  Dio dio = new Dio();
  int recentCount = 0;
  String url = 'http://85.25.105.49/api/musics?';
  Map<String, List<Song>> categories = {
    'lebanese': <Song>[],
    'english': <Song>[],
    'french': <Song>[],
    'others': <Song>[],
  };
  get lebanese => categories['lebanese'];
  get english => categories['english'];
  get french => categories['french'];
  get others => categories['others'];
  get isLoaded => _isLoaded;
  set setLoadedStatus(bool status) {
    _isLoaded = status;
    notifyListeners();
  }

  getSong(String category) async {
    if (await localStorage.ready) {
      var temp = await localStorage.getItem(category);
      if (temp == null) {
        dio.get(url + 'language=$category').then((res) async {
          categories[category] =
              res.data.map<Song>((d) => Song.fromMap(d)).toList();
          if (await localStorage.ready) {
            await localStorage.setItem(category, res.data);
          }
          notifyListeners();
        });
      } else {
        categories[category] = temp.map<Song>((d) => Song.fromMap(d)).toList();
        dio.get('http://85.25.105.49/api/musics/count').then((res) {
          // loop through the array and match the language to the current category
          res.data.map((data) {
            //when matched, check if the total from the server is same
            // with the one from localStorage
            if (data['language'].toUppercase() ==
                categories.keys.firstWhere((key) {
                  return data['language'].toUppercase() == key.toUpperCase();
                }).toUpperCase()) {
              if (data['total'] != categories[category].length) {
                print('update please!!!');

                dio.get(url + 'language=$category').then((res) async {
                  categories[category] =
                      res.data.map<Song>((d) => Song.fromMap(d)).toList();
                  if (await localStorage.ready) {
                    await localStorage.setItem(category, res.data);
                  }
                  notifyListeners();
                });
              }
            }
          });
        }).catchError((err) {
          print(err);
        });
        notifyListeners();
      }
    } else {
      dio.get(url + 'language=$category').then((res) async {
        categories[category] =
            res.data.map<Song>((d) => Song.fromMap(d)).toList();
        notifyListeners();
      });
    }
  }
}
