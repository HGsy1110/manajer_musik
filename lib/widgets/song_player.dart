import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SongPlayer extends StatefulWidget {
  final String songPath;

  const SongPlayer({super.key, required this.songPath});

  @override
  _SongPlayerState createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> {
  late AudioPlayer _audioPlayer;
  PlayerState _playerState = PlayerState.stopped;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  void _playPause() async {
    if (_playerState == PlayerState.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(widget.songPath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
          _playerState == PlayerState.playing ? Icons.pause : Icons.play_arrow),
      onPressed: _playPause,
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
