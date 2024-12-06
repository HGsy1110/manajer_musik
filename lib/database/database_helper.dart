import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';
import '../models/album_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('music_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE artists (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE albums (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        artist_id INTEGER,
        FOREIGN KEY (artist_id) REFERENCES artists (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE songs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        file_path TEXT NOT NULL,
        artist_id INTEGER,
        album_id INTEGER,
        FOREIGN KEY (artist_id) REFERENCES artists (id),
        FOREIGN KEY (album_id) REFERENCES albums (id)
      )
    ''');
  }

  // CRUD for Artists
  Future<Artist> createArtist(Artist artist) async {
    final db = await instance.database;
    final id = await db.insert('artists', artist.toMap());
    return artist.copyWith(id: id);
  }

  Future<Artist?> getArtistById(int id) async {
    final db = await instance.database;
    final result = await db.query('artists', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Artist.fromMap(result.first) : null;
  }

  Future<int> updateArtist(Artist artist) async {
    final db = await instance.database;
    return await db.update(
      'artists',
      artist.toMap(),
      where: 'id = ?',
      whereArgs: [artist.id],
    );
  }

  Future<void> deleteArtist(int id) async {
    final db = await instance.database;
    await db.delete('artists', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD for Albums
  Future<Album> createAlbum(Album album) async {
    final db = await instance.database;
    final id = await db.insert('albums', album.toMap());
    return album.copyWith(id: id);
  }

  Future<List<Album>> readAllAlbums() async {
    final db = await instance.database;
    final result = await db.query('albums');
    return result.map((map) => Album.fromMap(map)).toList();
  }

  Future<int> updateAlbum(Album album) async {
    final db = await instance.database;
    return await db.update(
      'albums',
      album.toMap(),
      where: 'id = ?',
      whereArgs: [album.id],
    );
  }

  Future<void> deleteAlbum(int id) async {
    final db = await instance.database;
    await db.delete('albums', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD for Songs
  Future<Song> createSong(Song song) async {
    final db = await instance.database;
    final id = await db.insert('songs', song.toMap());
    return song.copyWith(id: id);
  }

  Future<List<Song>> readAllSongs() async {
    final db = await instance.database;
    final result = await db.query('songs');
    return result.map((map) => Song.fromMap(map)).toList();
  }

  Future<int> updateSong(Song song) async {
    final db = await instance.database;
    return await db.update(
      'songs',
      song.toMap(),
      where: 'id = ?',
      whereArgs: [song.id],
    );
  }

  Future<void> deleteSong(int id) async {
    final db = await instance.database;
    await db.delete('songs', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Artist>> readAllArtists() async {
    final db = await instance.database;
    final result = await db.query('artists');
    return result.map((map) => Artist.fromMap(map)).toList();
  }
}
