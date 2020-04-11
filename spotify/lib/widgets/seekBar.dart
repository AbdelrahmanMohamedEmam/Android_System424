import 'package:flutter/material.dart';

///Seek Bar widget.
///It is given the total duration of the track and the current position to show the song progress bar for the [Panel].
class PanelSeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  PanelSeekBar({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _PanelSeekBarState createState() => _PanelSeekBarState();
}

class _PanelSeekBarState extends State<PanelSeekBar> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Duration left = widget.duration - widget.position;
    return Column(
      children: <Widget>[
        Slider(
          activeColor: Colors.white,
          min: 0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: _dragValue ?? widget.position.inMilliseconds.toDouble(),
          onChanged: (value) {
            setState(() {
              _dragValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged(Duration(milliseconds: value.round()));
            }
          },
          onChangeEnd: (value) {
            _dragValue = null;
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd(Duration(milliseconds: value.round()));
            }
          },
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: deviceSize.width * 0.05,
            ),
            Text(
              widget.position.inMinutes.toString().padLeft(2, '0') +
                  ':' +
                  (widget.position.inSeconds - widget.position.inMinutes * 60)
                      .toString()
                      .padLeft(2, '0'),
              style: TextStyle(color: Colors.white60),
            ),
            SizedBox(
              width: deviceSize.width * 0.7,
            ),
            Text(
              (left.inMinutes).toString().padLeft(2, '0') +
                  ':' +
                  (left.inSeconds - left.inMinutes * 60)
                      .toString()
                      .padLeft(2, '0'),
              style: TextStyle(color: Colors.white60),
            )
          ],
        )
      ],
    );
  }
}

///Seek Bar widget.
///It is given the total duration of the track and the current position to show the song progress bar for the [Collapsed].
class CollapsedSeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  CollapsedSeekBar({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _CollapsedSeekBarState createState() => _CollapsedSeekBarState();
}

class _CollapsedSeekBarState extends State<CollapsedSeekBar> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SliderTheme(
        data: SliderThemeData(
          thumbShape: SliderComponentShape.noThumb,
          trackHeight: deviceSize.height * 0.007,
          overlayShape: SliderComponentShape.noThumb,
        ),
        child: Slider(
          activeColor: Colors.white,
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: _dragValue ?? widget.position.inMilliseconds.toDouble(),
          onChanged: (value) {
            setState(() {
              _dragValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged(Duration(milliseconds: value.round()));
            }
          },
          onChangeEnd: (value) {
            _dragValue = null;
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd(Duration(milliseconds: value.round()));
            }
          },
        ));
  }
}
