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
    // wordBookCollection[index] =
    final Word wordToCreate = Word(word: word, meaning: meaning);
    currentWordBook = WordBook(
        title: currentWordBook.title,
        contents: [...currentWordBook.contents, wordToCreate]);
    notifyListeners();
  }
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

  WordBook({required this.title, required this.contents, id}) : id = uuid.v4();
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
