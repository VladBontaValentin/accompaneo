import 'package:accompaneo/models/browseable.dart';
import 'package:accompaneo/models/image.dart';
import 'package:accompaneo/models/page.dart';

class Playlist extends Browseable {

  bool favourites;

  bool latestPlayed;

  Page firstPageSongs;

  // Constructor
  Playlist({
    required super.code,
    required super.name,
    required super.picture,
    required this.favourites,
    required this.latestPlayed,
    required this.firstPageSongs
  });

  static Playlist fromJson(Map<String, dynamic> json) => Playlist(
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        picture: json['picture'] != null ? ImageData.fromJson(json['picture']) : ImageData(code: '', url: ''),
        favourites:  json['favourites'] ?? false,
        latestPlayed:  json['latestPlayed'] ?? false,
        firstPageSongs: json['firstPageSongs'] != null ? Page.fromJson(json['firstPageSongs']) : Page(number: 0, size: 0, totalElements: 0, totalPages: 0, content: [])
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'picture': picture != null ? picture!.toJson() : '',
        'songs': firstPageSongs,
      };
}