import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Word extends ChangeNotifier {
  final String id;
  final DateTime createdAt;
  String word;
  String meaning;
  String description;
  int checked;

  Word({
    required this.word,
    required this.meaning,
    this.checked = 0,
    this.description = '',
  })  : id = uuid.v4(),
        createdAt = DateTime.now();

  void editWord({
    required String newWord,
    required String newMeaning,
  }) {
    word = newWord;
    meaning = newMeaning;
    notifyListeners();
  }
}
