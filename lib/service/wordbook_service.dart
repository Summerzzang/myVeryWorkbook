import 'package:flutter/material.dart';
import 'package:my_wordbook/service/dummy_data.dart';
import 'package:my_wordbook/service/word_service.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class WordbookService with ChangeNotifier {
  late String currentWordBookId;
  late WordBook currentWordBook;
  List<WordBookInfo> wordBookCollection = dataSource
      .map(
        (wb) => WordBookInfo(id: wb.id, title: wb.title),
      )
      .toList();

  WordBook getWordBookFromId(targetId) =>
      dataSource.firstWhere((wb) => wb.id == targetId);

  WordbookService() {
    currentWordBookId = 'dummy';
    currentWordBook = getWordBookFromId(currentWordBookId);
    // sortingWithPawNumbers(currentWordBook.contents);
  }

  void changeCurrentWordBook(String wordBookId) {
    currentWordBookId = wordBookId;
    currentWordBook = getWordBookFromId(currentWordBookId);
    notifyListeners();
  }

  //CRUD -> Word
  void addWordToWordbook({
    required String word,
    required String meaning,
  }) {
    final Word wordToCreate = Word(word: word, meaning: meaning);
    currentWordBook.contents = [wordToCreate, ...currentWordBook.contents];
    int currentIndex =
        dataSource.indexWhere((wb) => wb.id == currentWordBookId);
    dataSource[currentIndex] = currentWordBook;
    notifyListeners();
  }

//Todo 더블탭하면 자동으로 다음 단어로 넘어가기
  void checkedIncrement(String wordId) {
    final int currentWordIndex =
        currentWordBook.contents.indexWhere((word) => word.id == wordId);
    Word targetWord = currentWordBook.contents[currentWordIndex];
    if (targetWord.checked < 3) {
      targetWord.checked++;
    }
  }

  void sortingWithPawNumbers(bool isReverse) {
    currentWordBook.contents.sort((a, b) => a.checked.compareTo(b.checked));
    isReverse
        ? currentWordBook.contents =
            [...currentWordBook.contents].reversed.toList()
        : currentWordBook.contents = [...currentWordBook.contents];
  }
}

class WordBook {
  final String id;
  String title;
  List<Word> contents;

  WordBook({required this.title, required this.contents, String? id})
      : id = id ?? uuid.v4();
}

class WordBookInfo {
  final String id;
  String title;

  WordBookInfo({
    required this.id,
    required this.title,
  });
}
