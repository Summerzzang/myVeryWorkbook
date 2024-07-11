import 'package:flutter/material.dart';
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
  String? errorController1;
  String? errorController2;

  @override
  void initState() {
    super.initState();
    _textController1 = TextEditingController(text: widget.initialWord?.word);
    _textController2 = TextEditingController(text: widget.initialWord?.meaning);
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
        title: const Text('단어 생성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              cursorColor: DecoConst.blackFontColor,
              controller: _textController1,
              decoration: inputDecorationFunc("단어", errorController1),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    errorController1 = null;
                  });
                }
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              cursorColor: DecoConst.blackFontColor,
              controller: _textController2,
              decoration: inputDecorationFunc("의미", errorController2),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    errorController2 = null;
                  });
                }
              },
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
                  if (theWord.isEmpty) {
                    setState(() {
                      errorController1 = "단어를 입력해주세요!";
                    });
                  } else if (theMeaning.isEmpty) {
                    setState(() {
                      errorController2 = "의미를 입력해주세요!";
                    });
                  } else {
                    widget.initialWord != null
                        ? wordBookService.editWordToWordbook(
                            wordId: widget.initialWord!.id,
                            word: theWord,
                            meaning: theMeaning,
                          )
                        : wordBookService.addWordToWordbook(
                            word: theWord,
                            meaning: theMeaning,
                          );
                    Navigator.pop(context, _textController1.text);
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

  InputDecoration inputDecorationFunc(String labelText, String? errorCon) {
    return InputDecoration(
      errorText: errorCon,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: DecoConst.blackFontColor,
      ),
      // filled: true,
      // fillColor: DecoConst.mainColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
