import 'package:accompaneo/models/page.dart';

class Playlist {

  String code;

  String name;

  bool favourites;

  Page firstPageSongs;

  // Constructor
  Playlist({
    required this.code,
    required this.name,
    required this.favourites,
    required this.firstPageSongs
  });

  Playlist copy({
    String? code,
    String? name,
    Page? songs
  }) =>
      Playlist(
        code: code ?? this.code,
        name: name ?? this.name,
        favourites: favourites ?? this.favourites,
        firstPageSongs: firstPageSongs ?? this.firstPageSongs
      );

  static Playlist fromJson(Map<String, dynamic> json) => Playlist(
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        favourites:  json['favourites'] ?? false,
        firstPageSongs: json['firstPageSongs'] != null ? Page.fromJson(json['firstPageSongs']) : Page(number: 0, size: 0, totalElements: 0, totalPages: 0, content: [])
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'songs': firstPageSongs
      };
}