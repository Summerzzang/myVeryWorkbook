import 'package:flutter/material.dart';
import 'package:my_wordbook/service/word_service.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:provider/provider.dart';

class CreateWordPage extends StatefulWidget {
  final Word? initialWord;

  const CreateWordPage({super.key, this.initialWord});

  @override
  _CreateWordPageState createState() => _CreateWordPageState();
}

class _CreateWordPageState extends State<CreateWordPage> {
  late TextEditingController _textController1;
  late TextEditingController _textController2;
  late TextEditingController _textController3;

  @override
  void initState() {
    super.initState();
    _textController1 = TextEditingController(text: widget.initialWord?.word);
    _textController2 = TextEditingController(text: widget.initialWord?.meaning);
    _textController3 =
        TextEditingController(text: widget.initialWord?.description);
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WordbookService wordBookService = context.read<WordbookService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '단어 생성',
          style: TextStyle(
            fontFamily: 'hannaAir',
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/images/title_box.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: getTextField(_textController1, '단어'),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/images/title_box.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: getTextField(_textController2, '의미'),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/images/title_box.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: getTextField(_textController3, '설명'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      DecoConst.cardColor,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      DecoConst.whiteFontColor,
                    )),
                onPressed: () {
                  String theWord = _textController1.text;
                  String theMeaning = _textController2.text;
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  if (theWord.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: DecoConst.secondColor,
                      content: Text(
                        '단어를 입력해주세요!',
                        style: TextStyle(
                          color: DecoConst.whiteFontColor,
                          fontSize: 16,
                          fontFamily: 'hannaAir',
                        ),
                      ),
                    ));
                  } else if (theMeaning.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: DecoConst.secondColor,
                      content: Text(
                        '의미를 입력해주세요!',
                        style: TextStyle(
                          color: DecoConst.whiteFontColor,
                          fontSize: 16,
                          fontFamily: 'hannaAir',
                        ),
                      ),
                    ));
                  } else {
                    widget.initialWord != null
                        ? widget.initialWord?.editWord(
                            newWord: theWord,
                            newMeaning: theMeaning,
                          )
                        : wordBookService.addWordToWordbook(
                            word: theWord,
                            meaning: theMeaning,
                          );

                    Navigator.pop(context);
                  }
                },
                child: const Icon(
                  Icons.edit,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField getTextField(textController, labelText) {
    return TextField(
      cursorColor: DecoConst.blackFontColor,
      controller: textController,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: DecoConst.blackFontColor,
          fontFamily: 'hannaAir',
        ),
        border: InputBorder.none,
        // filled: true,
      ),
      style: const TextStyle(
        fontFamily: 'hannaAir',
        fontSize: 20,
      ),
    );
  }
}
