import 'package:drinkandsing/data/song.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class FavBloc with ChangeNotifier {
  LocalStorage localStorage = new LocalStorage('favorite');
  List<Song> _favorite = [];
  bool _isLoading = true;
  get favorite => _favorite;
  get isLoading => _isLoading;

  FavBloc() {
    localStorage.ready.then((res) async {
      if (res) {
        var temp = await localStorage.getItem('favorites');
        if (temp != null) {
          _isLoading = false;
          _favorite = temp.map<Song>((d) => Song.fromMap(d)).toList();
          notifyListeners();
        } else {
          _isLoading = false;
        }
      }
    });
  }

  // FavBloc()
  void addFav(Song song) {
    if (!_favorite.contains(song)) {
      _favorite.add(song);
      localStorage.setItem(
          'favorites', _favorite.map((fav) => Song.toMap(fav)).toList());
      notifyListeners();
    }
  }

  void removeFav(Song song) {
    if (_favorite.contains(song)) {
      _favorite.remove(song);
      localStorage.setItem(
          'favorites', _favorite.map((fav) => Song.toMap(fav)).toList());
      notifyListeners();
    }
  }
}
