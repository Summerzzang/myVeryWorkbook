import 'package:flutter/material.dart';
import 'package:my_wordbook/pages/create_word.dart';
import 'package:my_wordbook/service/word_service.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:my_wordbook/utils/card_animation.dart';
import 'package:provider/provider.dart';

class WordCard extends StatefulWidget {
  const WordCard({
    super.key,
  });

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard>
    with SingleTickerProviderStateMixin {
  late WordCardAnimations _animations;
  bool _showMeaning = false;

  @override
  void initState() {
    super.initState();
    _animations = WordCardAnimations(this);

    _animations.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animations.controller.reverse();
      }
    });
  }

  void _handleDoubleTap(Word word) {
    WordbookService wordbookService = context.read<WordbookService>();
    if (word.checked < 3 && !_animations.controller.isAnimating) {
      wordbookService.checkedIncrement(word.id);
      _animations.controller.forward();
    }
  }

  void _handleLongPressStart(LongPressStartDetails details) {
    setState(() {
      _showMeaning = true;
    });
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    setState(() {
      _showMeaning = false;
    });
  }

  @override
  void dispose() {
    _animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Word>(builder: (context, word, child) {
      print("Word card");
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateWordPage(
                initialWord: word,
              ),
              //fullscreenDialog: true,
            ),
          );
        },
        onDoubleTap: () {
          _handleDoubleTap(word);
        },
        onLongPressStart: _handleLongPressStart,
        onLongPressEnd: _handleLongPressEnd,
        child: AnimatedBuilder(
            animation: _animations.controller,
            builder: (context, child) {
              return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/card_box.png'),
                        fit: BoxFit.fitWidth,
                      )
                      // color: word.checked == 3
                      //     ? DecoConst.mainColor
                      //     : _animations.colorAnimation.value,
                      ),
                  child: _showMeaning
                      ? Center(
                          child: Text(
                            word.meaning,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 38,
                              color: DecoConst.blackFontColor,
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Transform.scale(
                                scale: _animations.scaleAnimation.value,
                                child: Text(
                                  word.word,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: DecoConst.blackFontColor,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  3,
                                  (index) {
                                    return Transform.rotate(
                                        angle: index == word.checked - 1
                                            ? _animations
                                                .rotationAnimation.value
                                            : 0.0,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                word.checked > index
                                                    ? 'assets/icons/paw_pink.png'
                                                    : 'assets/icons/paw_lined.png',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ));
            }),
      );
    });
  }
}
