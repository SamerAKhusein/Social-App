import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:social/shared/styles/colors.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  AudioPlayerWidget({required this.audioUrl});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  FlutterSoundPlayer? _audioPlayer;
  bool _isPlaying = false;
  double _progress = 0.0;
  Timer? _progressTimer;
  String _audioDuration = "00:00";

  @override
  void initState() {
    super.initState();
    _audioPlayer = FlutterSoundPlayer();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    await _audioPlayer!.openPlayer();
    _audioPlayer!.onProgress!.listen((e) {
      if (e != null && e.position != null && e.duration != null) {
        final currentDuration = e.position;
        final totalDuration = e.duration;

        if (totalDuration > Duration.zero) {
          setState(() {
            _progress =
                currentDuration.inMilliseconds.toDouble() / totalDuration.inMilliseconds.toDouble();
            _audioDuration = _getFormattedDuration(totalDuration);
          });
        }
      }
    });
  }

  String _getFormattedDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _audioPlayer!.closePlayer();
    _audioPlayer = null;
    _stopProgressTracking();
    super.dispose();
  }

  void _startProgressTracking() {
    const progressInterval = Duration(milliseconds: 500);
    _progressTimer = Timer.periodic(progressInterval, (_) {
      if (_isPlaying) {
        // Nothing needs to be done here as the progress is tracked by the onProgress stream.
      }
    });
  }

  void _stopProgressTracking() {
    _progressTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(!_isPlaying)
            IconButton(
            onPressed: () {
              if (_isPlaying) {
                _audioPlayer!.pausePlayer();
                _stopProgressTracking();
              } else {
                _audioPlayer!.startPlayer(
                  fromURI: widget.audioUrl,
                  codec: Codec.aacADTS, // Change the codec based on your audio format
                );
                _startProgressTracking();

              }
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
            icon: Icon(
              Icons.play_arrow,
              size: 40,
              color: defaultColor,
            ),
            padding: EdgeInsets.zero,
          ),
          if(_isPlaying)
            IconButton(
            onPressed: () {
              _audioPlayer!.stopPlayer();
              setState(() {
                _isPlaying = false;
                _progress = 0.0;
                _stopProgressTracking();
              });
            },
            icon: Icon(
              Icons.stop,
              size: 40,
              color: defaultColor,
            ),
            padding: EdgeInsets.zero,
          ),
          SizedBox(width: 5),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 4,
                  color: defaultColor,
                ),
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progress,
                  child: Container(
                    height: 4,
                    color: defaultColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            _audioDuration,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
