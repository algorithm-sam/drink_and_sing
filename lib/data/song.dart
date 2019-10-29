class Song {
  String name, artist;
  int id;
  double relevance = 0;
  Song({this.id, this.name, this.artist, this.relevance});

  Song.fromMap(Map map) {
    this.id = map['id'];
    this.name = map['name'];
    this.artist = map['artist'];
    this.relevance = 0.0;
  }

  static Map<String, dynamic> toMap(Song song) {
    return {'name': song.name, 'artist': song.artist, 'id': song.id, 'relevance' : 0.0};
  }

}
