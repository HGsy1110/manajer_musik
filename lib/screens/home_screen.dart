import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/artist_model.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Artist> _artists = [];

  @override
  void initState() {
    super.initState();
    _loadArtists();
  }

  Future<void> _loadArtists() async {
    final artists = await DatabaseHelper.instance.readAllArtists();
    setState(() {
      _artists = artists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Library'),
      ),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: _artists.length,
        itemBuilder: (context, index) {
          final artist = _artists[index];
          return ExpansionTile(
            title: Text(artist.name),
            subtitle: Text(artist.description),
            children: const [
              // Song list for each artist
              // Implement song player here
            ],
          );
        },
      ),
    );
  }
}
