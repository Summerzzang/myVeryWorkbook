import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Word extends ChangeNotifier {
  final String id;
  String word;
  String meaning;
  int checked;

  Word({
    required this.word,
    required this.meaning,
    this.checked = 0,
  }) : id = uuid.v4();

  void editWord({
    required String newWord,
    required String newMeaning,
  }) {
    word = newWord;
    meaning = newMeaning;
    notifyListeners();
  }
}
