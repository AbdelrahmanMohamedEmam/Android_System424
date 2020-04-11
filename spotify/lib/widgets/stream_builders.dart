import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../widgets/seekBar.dart';


///It is used to provide the [PanelSeekBar] with the needed data about the track.
StreamBuilder panelBar(AudioPlayer _player) {
  return StreamBuilder<Duration>(
    stream: _player.durationStream,
    builder: (context, snapshot) {
      final duration = snapshot.data ?? Duration.zero;
      return StreamBuilder<Duration>(
        stream: _player.getPositionStream(),
        builder: (context, snapshot) {
          var position = snapshot.data ?? Duration.zero;
          if (position > duration) {
            position = duration;
          }
          return PanelSeekBar(
            duration: duration,
            position: position,
            onChangeEnd: (newPosition) {
              _player.seek(newPosition);
            },
          );
        },
      );
    },
  );
}


///It is used to provide the [CollapsedSeekBar] with the needed data about the track.
StreamBuilder collapsedBar(AudioPlayer _player) {
  return StreamBuilder<Duration>(
    stream: _player.durationStream,
    builder: (context, snapshot) {
      final duration = snapshot.data ?? Duration.zero;
      return StreamBuilder<Duration>(
        stream: _player.getPositionStream(),
        builder: (context, snapshot) {
          var position = snapshot.data ?? Duration.zero;
          if (position > duration) {
            position = duration;
          }
          return CollapsedSeekBar(
            duration: duration,
            position: position,
            onChangeEnd: (newPosition) {
              _player.seek(newPosition);
            },
          );
        },
      );
    },
  );
}