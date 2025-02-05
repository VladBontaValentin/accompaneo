import 'package:accompaneo/models/image.dart';

class Browseable {
  final String code;
  final String name;
  final ImageData? picture;

  // Constructor
  Browseable({
    required this.code,
    required this.name,
    required this.picture
  });

  Browseable copy({
    String? code,
    String? name,
    ImageData? picture
  }) =>
      Browseable(
        code: code ?? this.code,
        name: name ?? this.name,
        picture: picture ?? this.picture
      );

  static Browseable fromJson(Map<String, dynamic> json) => Browseable(
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        picture: json['picture'] != null ? ImageData.fromJson(json['picture']) : ImageData(code: '', url: '')
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'picture': picture != null ? picture!.toJson() : '',
      };


  @override
  bool operator ==(Object other) =>
      other is Browseable &&
      other.runtimeType == runtimeType &&
      other.code == code;

  @override
  int get hashCode => code.hashCode;
}