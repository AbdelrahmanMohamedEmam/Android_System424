import 'package:flutter/material.dart';

///Seek Bar widget.
class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Duration left=widget.duration-widget.position;
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

class SeekBar2 extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar2({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBar2State createState() => _SeekBar2State();
}

class _SeekBar2State extends State<SeekBar2> {
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
