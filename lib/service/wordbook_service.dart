import 'package:flutter/material.dart';

class WordbookService with ChangeNotifier {
  List<Wordbook> wordbookList = [
    Wordbook(
      word: "香辛料",
      meaning: '향신료',
    ),
    Wordbook(
      word: "国境",
      meaning: '국경',
    ),
    Wordbook(
      word: "香辛料",
      meaning: '향신료',
    ),
    Wordbook(
      word: "国境",
      meaning: '국경',
    ),
    Wordbook(
      word: "香辛料",
      meaning: '향신료',
    ),
    Wordbook(
      word: "国境",
      meaning: '국경',
    ),
    Wordbook(
      word: "香辛料",
      meaning: '향신료',
    ),
    Wordbook(
      word: "国境",
      meaning: '국경',
    )
  ];
}

class Wordbook {
  String word;
  String meaning;
  int checked = 0;

  Wordbook({
    required this.word,
    required this.meaning,
  });
}
