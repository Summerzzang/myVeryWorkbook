import 'package:flutter/material.dart';
import 'package:my_wordbook/pages/create_word.dart';
import 'package:my_wordbook/pages/wordbook_card.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Word> wordBookContents = context.select<WordbookService, List<Word>>(
        (WordbookService service) => service.currentWordBook.contents);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateWordPage(),
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
                  child: const Text(
                    "짜마의 단어장",
                    style: TextStyle(
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
                  return WordCard(word: wordBookContents[index]);
                },
                childCount: wordBookContents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
