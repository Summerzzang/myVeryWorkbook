import 'package:flutter/material.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.wordbook,
  });

  final Wordbook wordbook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 7),
          padding: const EdgeInsets.all(15),
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: DecoConst.cardColor,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  wordbook.word,
                  style: const TextStyle(
                    fontSize: 25,
                    color: DecoConst.whiteFontColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: List.generate(
                    3,
                    (index) {
                      return Icon(
                        wordbook.checked > index
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: wordbook.checked > index
                            ? DecoConst.mainColor
                            : DecoConst.whiteFontColor,
                        size: 22,
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
