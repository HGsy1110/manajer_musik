import 'package:manajer_musik/models/song_model.dart';

class Artist {
  int? id;
  String name;
  String description;
  List<Song>? songs;

  Artist({
    this.id,
    required this.name,
    required this.description,
    this.songs,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  // Tambahkan method copyWith
  Artist copyWith({
    int? id,
    String? name,
    String? description,
    List<Song>? songs,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      songs: songs ?? this.songs,
    );
  }

  // Tambahan method untuk validasi
  bool isValid() {
    return name.isNotEmpty && description.isNotEmpty;
  }

  // Override toString untuk debugging
  @override
  String toString() {
    return 'Artist{id: $id, name: $name, description: $description, songCount: ${songs?.length ?? 0}}';
  }
}
