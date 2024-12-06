import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/artist_model.dart';

class EditArtistScreen extends StatefulWidget {
  final Artist artist;

  const EditArtistScreen({super.key, required this.artist});

  @override
  _EditArtistScreenState createState() => _EditArtistScreenState();
}

class _EditArtistScreenState extends State<EditArtistScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;

  @override
  void initState() {
    super.initState();
    _name = widget.artist.name;
    _description = widget.artist.description;
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedArtist = Artist(
        id: widget.artist.id,
        name: _name,
        description: _description,
      );
      await DatabaseHelper.instance.updateArtist(updatedArtist);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Artist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Artist Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter artist name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Update Artist'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
