import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/song_model.dart';

class AddSongScreen extends StatefulWidget {
  final int artistId;

  const AddSongScreen({super.key, required this.artistId});

  @override
  _AddSongScreenState createState() => _AddSongScreenState();
}

class _AddSongScreenState extends State<AddSongScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _filePath = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final song =
          Song(title: _title, filePath: _filePath, artistId: widget.artistId);
      await DatabaseHelper.instance.createSong(song);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Song'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
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
                child: const Text('Add Song'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
