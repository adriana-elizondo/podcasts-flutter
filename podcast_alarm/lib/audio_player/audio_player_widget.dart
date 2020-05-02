import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cache_audio_player/cache_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:podcast_alarm/data_layer/episode.dart';
import 'audio_player_bloc.dart';

class AudioPlayerWidget extends StatefulWidget {
  AudioPlayerBloc audioPlayerBloc;

  AudioPlayerWidget({@required this.audioPlayerBloc});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  CacheAudioPlayer _audioPlayer;

  StreamSubscription<AudioPlayerState> _stateSubscription;
  StreamSubscription<double> _bufferSubscription;
  StreamSubscription<double> _timeElapsedSubscription;
  StreamSubscription<Object> _errorSubscription;

  AudioPlayerState _state = AudioPlayerState.PAUSED;
  double _bufferedPercentage = 0;
  double _timeInSeconds = 0;
  double _percentageOfTimeElapsed = 0;
  int _totalDuration = 0;
  Object _error;
  bool _isSeekng = false;
  double _valueToSeekTo = 0;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  void _setup() {
    _audioPlayer = CacheAudioPlayer();
    _stateSubscription =
        _audioPlayer.onStateChanged.listen((AudioPlayerState state) {
          setState(() {
            _state = state;
          });
        });
    _bufferSubscription =
        _audioPlayer.onPlayerBuffered.listen((double percentageBuffered) {
          setState(() {
            _bufferedPercentage = percentageBuffered;
          });
        });
    _timeElapsedSubscription =
        _audioPlayer.onTimeElapsed.listen((double timeInSeconds) {
          setState(() {
            _timeInSeconds = timeInSeconds;
          });
        });
    _errorSubscription = _audioPlayer.onError.listen((Object error) {
      setState(() {
        _error = error;
      });
    });

    widget.audioPlayerBloc.episodeStream.listen((Episode episode) {
      _audioPlayer.registerListeners();
      _setupWithUrl(episode);
    });
  }

  Future<Directory> _downloadsDirectory() async {
    Directory dir = await getApplicationSupportDirectory();
    return Directory("${dir.path}/downloads/");
  }

  _setupWithUrl(Episode episode) async {
    Directory downloadsDir = await _downloadsDirectory();
    bool exists = await File("${downloadsDir.path}${episode.id}.mp3").exists();
    print("exists $exists");
    if (exists) {
      _audioPlayer.loadFromFile("${downloadsDir.path}${episode.id}.mp3");
    } else {
      _audioPlayer.loadUrl(episode.audio);
    }
  }

  @override
  void dispose() {
    _resetValues();
    _stateSubscription.cancel();
    _bufferSubscription.cancel();
    _errorSubscription.cancel();
    _timeElapsedSubscription.cancel();
    super.dispose();
  }

  void _resetValues() {
    _bufferedPercentage = 0;
    _state = AudioPlayerState.PAUSED;
    _timeInSeconds = 0;
    _percentageOfTimeElapsed = 0;
    _totalDuration = 0;
    _error = null;
    _isSeekng = false;
    _valueToSeekTo = 0;
    _audioPlayer.stop();
    _audioPlayer.unregisterListeners();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == AudioPlayerState.PLAYING ||
        _isSeekng ||
        _state == AudioPlayerState.FINISHED) {
      _updateSliderValue();
    }
    return _playerContainer();
  }

  _playerContainer() {
    return Container(
      child: Column(
        children: <Widget>[
          Slider(
            onChangeEnd: (double value) {
              _valueToSeekTo = value;
              _isSeekng = true;
              _audioPlayer.seek(value).catchError((Object error) {
                setState(() {
                  _isSeekng = false;
                  _error = error;
                });
              });
            },
            onChanged: (value) {},
            value: _percentageOfTimeElapsed,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${formattedTime(_timeInSeconds)}"),
              Text("-${formattedTime(_totalDuration - _timeInSeconds)}"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              IconButton(
                iconSize: 50,
                color: Colors.white,
                icon: Icon(Icons.skip_previous),
                onPressed: () {
                  _loadPrevious();
                },
              ),
              IconButton(
                iconSize: 60,
                color: Colors.white,
                icon: _icon(),
                onPressed: () {
                  _onPressed();
                },
              ),
              IconButton(
                iconSize: 50,
                color: Colors.white,
                icon: Icon(Icons.skip_next),
                onPressed: () {
                  _loadNext();
                },
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Text("Buffer: $_bufferedPercentage"),
            ],
          ),
          _error == null ? SizedBox() : Text("there was an error $_error"),
        ],
      ),
    );
  }

  _loadPrevious() {
    _resetValues();
    widget.audioPlayerBloc.previousEpisode();
  }

  _loadNext() {
    _resetValues();
    widget.audioPlayerBloc.nextEpisode();
  }

  String formattedTime(double time) {
    return Duration(seconds: time.toInt())
        .toString()
        .split('.')
        .first
        .padLeft(8, "0");
    ;
  }

  Icon _icon() {
    switch (_state) {
      case AudioPlayerState.PLAYING:
        return Icon(Icons.pause);
      case AudioPlayerState.READYTOPLAY:
      case AudioPlayerState.BUFFERING:
      case AudioPlayerState.PAUSED:
      case AudioPlayerState.FINISHED:
        return Icon(Icons.play_arrow);
      default:
        return Icon(Icons.error);
    }
  }

  _onPressed() {
    switch (_state) {
      case AudioPlayerState.PLAYING:
        return _audioPlayer.stop();
      case AudioPlayerState.READYTOPLAY:
      case AudioPlayerState.BUFFERING:
      case AudioPlayerState.PAUSED:
        return _audioPlayer.play();
      case AudioPlayerState.FINISHED:
        _percentageOfTimeElapsed = 0;
        _timeInSeconds = 0;
        return _audioPlayer.play();
      default:
        {}
    }
  }

  _updateSliderValue() {
    if (_state == AudioPlayerState.FINISHED) {
      _percentageOfTimeElapsed = 0;
      return;
    }
    if (_totalDuration == 0) {
      _audioPlayer.lengthInseconds().then((totalDuration) {
        _totalDuration = totalDuration.toInt();
      }).catchError((error) {
        _error = error;
      });
    } else {
      if (_isSeekng) {
        _isSeekng = false;
        final double value = _valueToSeekTo;
        _valueToSeekTo = 0;
        _percentageOfTimeElapsed = value;
      } else {
        _percentageOfTimeElapsed = min(_timeInSeconds / _totalDuration, 1.0);
      }
    }
  }

  onPlay() {
    _audioPlayer.play();
  }

  onPause() {
    _audioPlayer.stop();
  }

  onSeek(double value) {
    // Note: We can only seek if the audio is ready
    _audioPlayer.seek(value);
  }
}
