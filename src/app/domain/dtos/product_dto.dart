// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:collection/collection.dart';

class ProductDto {
  ProductDto({
    this.id,
    this.name,
    this.tags,
  });

  final int? id;
  final String? name;
  final List<String>? tags;

  ProductDto copyWith({
    int? id,
    String? name,
    List<String>? tags,
  }) {
    return ProductDto(
      id: id ?? this.id,
      name: name ?? this.name,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tags': tags,
    };
  }

  factory ProductDto.fromMap(Map<String, dynamic> map) {
    return ProductDto(
      id: map['id']?.toInt(),
      name: map['name'],
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDto.fromJson(String source) =>
      ProductDto.fromMap(json.decode(source));

  @override
  String toString() => 'ProductDto(id: $id, name: $name, tags: $tags)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ProductDto &&
        other.id == id &&
        other.name == name &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ tags.hashCode;
}
