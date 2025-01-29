import 'package:accompaneo/models/artist.dart';
import 'package:accompaneo/models/browseable.dart';
import 'package:accompaneo/models/image.dart';

class Song extends Browseable{
  Artist artist;
  double bpm;
  bool favoured;

  // Constructor
  Song({
    required super.code, required super.name, required super.picture,
    required this.artist,
    required this.bpm,
    required this.favoured
  });

  static Song fromJson(Map<String, dynamic> json) => Song(
        code: json['code'] ?? '',
        name: json['title'] ?? '',
        picture: json['picture'] != null ? Image.fromJson(json['picture']) : Image(code: '', url: ''),
        artist: json['artist'] != null ? Artist.fromJson(json['artist']) : Artist(code: '', name: '', picture: Image(code: '', url: '')),
        bpm: json['bpm'] ?? 0.0,
        favoured: json['favoured'] ?? false
      );

  Map<String, dynamic> toJson() => {
        'code' : code,
        'title': name,
        'picture': picture != null ? picture!.toJson() : '',
        'artist': artist,
        'bpm': bpm,
        'favoured': favoured
      };
}