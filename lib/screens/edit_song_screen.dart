import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/song_model.dart';

class EditSongScreen extends StatefulWidget {
  final Song song;

  const EditSongScreen({super.key, required this.song});

  @override
  _EditSongScreenState createState() => _EditSongScreenState();
}

class _EditSongScreenState extends State<EditSongScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _filePath;

  @override
  void initState() {
    super.initState();
    _title = widget.song.title;
    _filePath = widget.song.filePath;
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedSong = Song(
        id: widget.song.id,
        title: _title,
        filePath: _filePath,
        artistId: widget.song.artistId,
      );
      await DatabaseHelper.instance.updateSong(updatedSong);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Song'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Song Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter song title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _filePath,
                decoration: const InputDecoration(labelText: 'File Path'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter file path';
                  }
                  return null;
                },
                onSaved: (value) => _filePath = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Update Song'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
