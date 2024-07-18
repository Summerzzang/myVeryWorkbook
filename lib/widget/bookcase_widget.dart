import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:provider/provider.dart';

class BookcaseWidget extends StatefulWidget {
  const BookcaseWidget({
    super.key,
    required this.title,
    required this.wordBookId,
    required this.onResetIndex,
  });

  final String title;
  final String wordBookId;
  final Function onResetIndex;

  @override
  State<BookcaseWidget> createState() => _BookcaseWidgetState();
}

class _BookcaseWidgetState extends State<BookcaseWidget> {
  var _isTapped = false;
  final Duration animationDuration = const Duration(milliseconds: 300);
  Timer? _timer;
  final int _delay = 2; // seconds

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: _delay), _onTimeout);
  }

  void _onTimeout() {
    setState(() {
      _isTapped = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

//Todo 아이콘부분 누르면 컨테이너 전체로 Tap이 안눌리는 버그 해결
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
        });
        _startTimer();
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: animationDuration,
            margin: const EdgeInsets.symmetric(vertical: 7),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 15,
            ),
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: DecoConst.cardColor,
            ),
            transform: Matrix4.translationValues(_isTapped ? -80 : 0, 0, 0),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: DecoConst.whiteFontColor,
                fontSize: 20,
              ),
            ),
          ),
          Positioned(
            right: 25,
            top: 0,
            bottom: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isTapped ? 1.0 : 0.0,
              curve: Curves.easeInOut,
              child: GestureDetector(
                onTap: () {
                  if (_isTapped) {
                    context
                        .read<WordbookService>()
                        .changeCurrentWordBook(widget.wordBookId);
                    _isTapped = false;
                    widget.onResetIndex();
                  }
                },
                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: DecoConst.mainColor,
                  foregroundColor: DecoConst.whiteFontColor,
                  child: Icon(
                    Icons.check,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
