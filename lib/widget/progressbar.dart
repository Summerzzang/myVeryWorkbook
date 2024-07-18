import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Progressbar extends StatefulWidget {
  const Progressbar({super.key});

  @override
  _ProgressbarState createState() => _ProgressbarState();
}

class _ProgressbarState extends State<Progressbar> {
  double _progress = 0.0;

  void _increaseProgress() {
    setState(() {
      _progress += 0.1;
      if (_progress > 1.0) {
        _progress = 1.0;
      }
    });
  }

  void _decreaseProgress() {
    setState(() {
      _progress -= 0.1;
      if (_progress < 0.0) {
        _progress = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: LinearPercentIndicator(
        padding: const EdgeInsets.all(0),
        curve: Curves.bounceInOut,
        lineHeight: 70.0,
        animation: true,
        animationDuration: 1000,
        percent: _progress,
        center: Text(
          '${(_progress * 100).toInt()}%',
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.grey[300],
        progressColor: Colors.blue,
        barRadius: const Radius.circular(15),
      ),
    );
  }
}
