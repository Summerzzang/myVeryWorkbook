import 'package:flutter/material.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';

class WordCard extends StatefulWidget {
  const WordCard({
    super.key,
    required this.wordbook,
  });

  final Wordbook wordbook;

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _rotationAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.2)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.1, end: -0.2)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.2, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);
    _colorAnimation = ColorTween(
      begin: DecoConst.cardColor,
      end: DecoConst.mainColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
        setState(() {
          if (widget.wordbook.checked < 3) {
            widget.wordbook.checked++;
          }
        });
      }
    });
  }

  void _handleDoubleTap() {
    if (!_controller.isAnimating) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                padding: const EdgeInsets.all(15),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _colorAnimation.value,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Text(
                          textAlign: TextAlign.center,
                          widget.wordbook.word,
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
                        children: List.generate(
                          3,
                          (index) {
                            return Transform.rotate(
                              angle: _rotationAnimation.value,
                              child: Icon(
                                widget.wordbook.checked > index
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                color: widget.wordbook.checked > index
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
