import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class WordbookService with ChangeNotifier {
  String currentWordBookId = 'dummy';
  late WordBook currentWordBook;
  List<WordBook> wordBookCollection = [
    WordBook(
      title: "타토미의 Wordbook",
      contents: dummyWordBook,
      id: 'dummy',
    ),
  ];

  WordbookService() {
    currentWordBook = wordBookCollection.firstWhere(
      (wb) => wb.id == currentWordBookId,
      orElse: () => wordBookCollection.first,
    );
  }

  //CRUD -> Word
  void addWordToWordbook({
    required String word,
    required String meaning,
  }) {
    final Word wordToCreate = Word(word: word, meaning: meaning);
    currentWordBook = WordBook(
        title: currentWordBook.title,
        contents: [...currentWordBook.contents, wordToCreate]);
    final int wbIndex =
        wordBookCollection.indexWhere((wb) => wb.id == currentWordBookId);
    wordBookCollection[wbIndex] = currentWordBook;
    notifyListeners();
  }

  void editWordToWordbook({
    required String wordId,
    required String word,
    required String meaning,
  }) {
    print("edit");
    int targetWordIndex =
        currentWordBook.contents.indexWhere((word) => word.id == wordId);
    print(currentWordBook.contents[targetWordIndex].word);
    currentWordBook.contents[targetWordIndex].word = word;
    currentWordBook.contents[targetWordIndex].meaning = meaning;
    print(currentWordBook.contents[targetWordIndex].word);

    final int wbIndex =
        wordBookCollection.indexWhere((wb) => wb.id == currentWordBookId);
    wordBookCollection[wbIndex] = currentWordBook;
    notifyListeners();
  }

  void checkedIncrement(String wordId) {
    Word targetWord =
        currentWordBook.contents.firstWhere((word) => word.id == wordId);
    if (targetWord.checked < 3) {
      targetWord.checked++;
      print(currentWordBook.contents
          .firstWhere((word) => word.id == wordId)
          .checked);
    }
  }

  void addChecked() {}
}

class Word {
  final String id;
  String word;
  String meaning;
  int checked;

  Word({
    required this.word,
    required this.meaning,
    this.checked = 0,
  }) : id = uuid.v4();
}

class WordBook {
  final String id;
  String title;
  List<Word> contents;

  WordBook({required this.title, required this.contents, String? id})
      : id = id ?? uuid.v4();
}

List<Word> dummyWordBook = [
  Word(
    word: "香辛料",
    meaning: '향신료',
    checked: 2,
  ),
  Word(
    word: "国境",
    meaning: '국경',
    checked: 3,
  ),
  Word(
    word: "香辛料",
    meaning: '향신료',
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
    word: "国境",
    meaning: '국경',
  ),
];
