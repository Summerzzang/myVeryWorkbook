import 'package:flutter/material.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:provider/provider.dart';

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
    return LayoutBuilder(builder: (context, constraints) {
      double screenWidth = constraints.maxWidth;
      return Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.transparent,
              image: const DecorationImage(
                image: AssetImage('assets/images/road.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Selector<WordbookService, double>(
            selector: (context, service) => service.currentWordBook.status,
            builder: (context, status, child) {
              print(screenWidth);
              print(status);
              print(status * screenWidth);

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: 0,
                bottom: 0,
                left: status * screenWidth - 110 - 15,
                child: SizedBox(
                  width: 110,
                  child: Image.asset(
                    'assets/images/runningmeow.png',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
