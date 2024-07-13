import 'package:flutter/material.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:provider/provider.dart';

class BookcaseWidget extends StatefulWidget {
  const BookcaseWidget({
    super.key,
    required this.wordBook,
  });

  final WordBook wordBook;

  @override
  State<BookcaseWidget> createState() => _BookcaseWidgetState();
}

class _BookcaseWidgetState extends State<BookcaseWidget> {
  var _isTapped = false;
  final Duration animationDuration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
        });
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
              widget.wordBook.title,
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
                  context
                      .read<WordbookService>()
                      .changeCurrentWordBook(widget.wordBook);
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
