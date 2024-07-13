import 'package:flutter/material.dart';
import 'package:my_wordbook/service/dummy_data.dart';
import 'package:my_wordbook/service/word_service.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class WordbookService with ChangeNotifier {
  String currentWordBookId = 'dummy';
  List<WordBook> wordBookCollection = [
    WordBook(
      title: "타토미의 Wordbook",
      contents: dummyWordBook,
      id: 'dummy',
    ),
    WordBook(
      title: "Wordbook 2",
      contents: [],
      id: 'dummy2',
    )
  ];

  WordBook getCurrentWordBook() {
    return wordBookCollection.firstWhere(
      (wb) => wb.id == currentWordBookId,
      orElse: () => wordBookCollection.first,
    );
  }

  void changeCurrentWordBook(WordBook wb) {
    currentWordBookId = wb.id;
    print(currentWordBookId);
  }

  //CRUD -> Word
  void addWordToWordbook({
    required String word,
    required String meaning,
  }) {
    final Word wordToCreate = Word(word: word, meaning: meaning);
    final int currentWBIndex =
        wordBookCollection.indexWhere((wb) => wb.id == currentWordBookId);
    wordBookCollection[currentWBIndex].contents.add(wordToCreate);
    notifyListeners();
  }

  void checkedIncrement(String wordId) {
    final int currentWBIndex =
        wordBookCollection.indexWhere((wb) => wb.id == currentWordBookId);
    List<Word> currentWBContents = wordBookCollection[currentWBIndex].contents;
    Word targetWord = currentWBContents.firstWhere((word) => word.id == wordId);
    if (targetWord.checked < 3) {
      targetWord.checked++;
    }
  }

  void addChecked() {}
}

class WordBook {
  final String id;
  String title;
  List<Word> contents;

  WordBook({required this.title, required this.contents, String? id})
      : id = id ?? uuid.v4();
}



// void editWordToWordbook({
  //   required String wordId,
  //   required String word,
  //   required String meaning,
  // }) {
  //   final int currentWBIndex =
  //       wordBookCollection.indexWhere((wb) => wb.id == currentWordBookId);
  //   List<Word> currentWBContents = wordBookCollection[currentWBIndex].contents;
  //   final int targetWordIndex =
  //       currentWBContents.indexWhere((word) => word.id == wordId);
  //   var targetWord = currentWBContents[targetWordIndex];
  //   targetWord
  //     ..word = word
  //     ..meaning = meaning;
  //   notifyListeners();
  // }