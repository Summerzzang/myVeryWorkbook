import 'package:my_wordbook/service/wordbook_service.dart';

import 'word_service.dart';

final List<Word> dummyContents = [
  Word(
    word: "落ち着きがない",
    meaning: '산만하다',
    description: '예를들면 가나다라 마바사사사삿',
    checked: 2,
  ),
  Word(
    word: "国境",
    meaning: '국경',
    checked: 3,
  ),
  Word(
    word: "売り上げが去年を下回る",
    meaning: '매출이 작년수준을 밑돌다',
    checked: 2,
  ),
  Word(
    word: "国境",
    meaning: '국경',
    checked: 1,
  ),
  Word(
    word: "香辛料",
    meaning: '향신료',
  ),
  Word(
    word: "予想を下回る",
    meaning: '예상에 못미치다',
  ),
];

List<WordBook> dataSource = [
  WordBook(title: "미야옹 일어 단어장", contents: dummyContents, id: 'dummy'),
  WordBook(title: "SUzie's Japanese", contents: [], id: 'dummy2')
];
