import 'package:flutter/material.dart';
import 'package:my_wordbook/pages/create_word.dart';
import 'package:my_wordbook/pages/wordbookCard.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context){
    WordBook wordBook =  context.select<WordbookService, WordBook>(
        (WordbookService service) => service.currentWordBook);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateWordPage(
                initialText: "Hi, Hello",
              ),
              //fullscreenDialog: true,
            ),
          );
        },
        backgroundColor: DecoConst.buttonColor,
        foregroundColor: DecoConst.secondColor,
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    wordBook.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: DecoConst.secondColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: DecoConst.secondColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_alt,
                        color: DecoConst.secondColor,
                      ),
                    ),
                  ],
                )
              ],
            )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final List<Word> wordBookContents = wordBook.contents;
                  return WordCard(word: wordBookContents[index]);
                },
                childCount: wordBook.contents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
