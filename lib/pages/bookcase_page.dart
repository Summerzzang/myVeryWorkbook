import 'package:flutter/material.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/widget/bookcase_widget.dart';
import 'package:provider/provider.dart';

class BookCasePage extends StatelessWidget {
  const BookCasePage({
    super.key,
    required this.onResetIndex,
  });

  final Function onResetIndex;

  @override
  Widget build(BuildContext context) {
    List<WordBookInfo> wordBookCollection =
        context.select<WordbookService, List<WordBookInfo>>(
            (service) => service.wordBookCollection);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookcase"),
      ),
      body: ListView.builder(
          itemCount: wordBookCollection.length,
          itemBuilder: (context, index) {
            WordBookInfo wordBookInfo = wordBookCollection[index];
            return BookcaseWidget(
                title: wordBookInfo.title,
                wordBookId: wordBookInfo.id,
                onResetIndex: onResetIndex);
          }),
    );
  }
}
