class Song {
  int? id;
  String title;
  String filePath;
  int artistId;
  int? albumId;
  Duration? duration;

  Song({
    this.id,
    required this.title,
    required this.filePath,
    required this.artistId,
    this.albumId,
    this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'file_path': filePath,
      'artist_id': artistId,
      'album_id': albumId,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'],
      title: map['title'],
      filePath: map['file_path'],
      artistId: map['artist_id'],
      albumId: map['album_id'],
    );
  }

  // Tambahkan method copyWith
  Song copyWith({
    int? id,
    String? title,
    String? filePath,
    int? artistId,
    int? albumId,
    Duration? duration,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      filePath: filePath ?? this.filePath,
      artistId: artistId ?? this.artistId,
      albumId: albumId ?? this.albumId,
      duration: duration ?? this.duration,
    );
  }

  // Tambahan method untuk validasi
  bool isValid() {
    return title.isNotEmpty && filePath.isNotEmpty && artistId > 0;
  }

  // Override toString untuk debugging
  @override
  String toString() {
    return 'Song{id: $id, title: $title, artistId: $artistId, albumId: $albumId}';
  }
}
