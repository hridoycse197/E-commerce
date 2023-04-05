import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String? name;

  @HiveField(1)
  Uint8List? images;

  // List<int>? photo;

  // @JsonKey(fromJson: _fromJson, toJson: _toJson)
  // Uint8List? photo;

  // static Uint8List? _fromJson(List<int> x) => Uint8List.fromList(x);
  // static Uint8List? _toJson(Uint8List? photo) => photo;

  User({this.name, this.images});
}
