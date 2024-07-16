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
    WordBook currentWordBook = wordBookCollection.firstWhere(
      (wb) => wb.id == currentWordBookId,
      orElse: () => wordBookCollection.first,
    );

    List<Word> sortedContents = List.from(currentWordBook.contents);
    sortedContents.sort((a, b) {
      if (a.checked == 3 && b.checked != 3) {
        return 1;
      } else if (a.checked != 3 && b.checked == 3) {
        return -1;
      }
      return 0;
    });
    currentWordBook.contents = sortedContents;
    return currentWordBook;
  }

  void changeCurrentWordBook(WordBook wb) {
    currentWordBookId = wb.id;
    notifyListeners();
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
      if (targetWord.checked == 3) {
        currentWBContents.remove(targetWord);
        currentWBContents.add(targetWord);
        notifyListeners();
      }
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