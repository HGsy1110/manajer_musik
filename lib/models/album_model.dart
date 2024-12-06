import 'package:manajer_musik/models/song_model.dart';

class Album {
  int? id;
  String title;
  String? coverImagePath;
  int artistId;
  int? releaseYear;
  String? genre;
  List<Song>? songs;

  Album({
    this.id,
    required this.title,
    this.coverImagePath,
    required this.artistId,
    this.releaseYear,
    this.genre,
    this.songs,
  });

  // Konversi objek ke Map untuk penyimpanan database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'cover_image_path': coverImagePath,
      'artist_id': artistId,
      'release_year': releaseYear,
      'genre': genre,
    };
  }

  // Membuat objek Album dari Map database
  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'],
      title: map['title'],
      coverImagePath: map['cover_image_path'],
      artistId: map['artist_id'],
      releaseYear: map['release_year'],
      genre: map['genre'],
    );
  }

  // Method copyWith untuk memudahkan pembaruan
  Album copyWith({
    int? id,
    String? title,
    String? coverImagePath,
    int? artistId,
    int? releaseYear,
    String? genre,
    List<Song>? songs,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      artistId: artistId ?? this.artistId,
      releaseYear: releaseYear ?? this.releaseYear,
      genre: genre ?? this.genre,
      songs: songs ?? this.songs,
    );
  }

  // Method untuk menghitung durasi total album
  Duration getTotalDuration() {
    if (songs == null || songs!.isEmpty) {
      return Duration.zero;
    }

    // Asumsikan setiap lagu memiliki method getDuration()
    return songs!.fold(
        Duration.zero,
        (previousValue, song) =>
            previousValue + (song.duration ?? Duration.zero));
  }

  // Method untuk mendapatkan jumlah lagu
  int get songCount => songs?.length ?? 0;

  // Method untuk menambahkan lagu ke album
  void addSong(Song song) {
    songs ??= [];
    songs!.add(song);
  }

  // Method untuk menghapus lagu dari album
  void removeSong(Song song) {
    songs?.remove(song);
  }

  // Method untuk mendapatkan lagu berdasarkan index
  Song? getSongAtIndex(int index) {
    if (songs != null && index >= 0 && index < songs!.length) {
      return songs![index];
    }
    return null;
  }

  // Override toString untuk debugging
  @override
  String toString() {
    return 'Album{id: $id, title: $title, artistId: $artistId, releaseYear: $releaseYear, genre: $genre, songCount: $songCount}';
  }

  // Method untuk validasi
  bool isValid() {
    return title.isNotEmpty && artistId > 0;
  }
}

// Extension untuk Song untuk mendukung Album
extension SongExtension on Song {
  // Misalnya menambahkan durasi lagu (opsional)
  Duration? get duration => null; // Implementasi aktual tergantung kebutuhan
}
