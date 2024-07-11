import 'package:flutter/material.dart';
import 'package:my_wordbook/pages/create_word.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:my_wordbook/utils/card_animation.dart';
import 'package:provider/provider.dart';

class WordCard extends StatefulWidget {
  const WordCard({
    super.key,
    required this.word,
  });

  final Word word;

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard>
    with SingleTickerProviderStateMixin {
  late WordCardAnimations _animations;

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

  void _handleDoubleTap(wordId) {
    if (widget.word.checked < 3 && !_animations.controller.isAnimating) {
      context.read<WordbookService>().checkedIncrement(wordId);
      _animations.controller.forward();
    }
  }

  void _onLongPress() {}

  @override
  void dispose() {
    _animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        _handleDoubleTap(widget.word.id);
      },
      onLongPress: _onLongPress,
      child: AnimatedBuilder(
          animation: _animations.controller,
          builder: (context, child) {
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 15,
                ),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _animations.colorAnimation.value,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        splashRadius: 20,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.topLeft,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateWordPage(
                                initialWord: widget.word,
                              ),
                              //fullscreenDialog: true,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.mode_edit_outlined,
                          color: DecoConst.whiteFontColor,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Transform.scale(
                        scale: _animations.scaleAnimation.value,
                        child: Text(
                          textAlign: TextAlign.center,
                          widget.word.word,
                          style: const TextStyle(
                            fontSize: 25,
                            color: DecoConst.whiteFontColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          3,
                          (index) {
                            return Transform.rotate(
                              angle: index == widget.word.checked - 1
                                  ? _animations.rotationAnimation.value
                                  : 0.0,
                              child: Icon(
                                widget.word.checked > index
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                color: widget.word.checked > index
                                    ? DecoConst.mainColor
                                    : DecoConst.whiteFontColor,
                                size: 22,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}
