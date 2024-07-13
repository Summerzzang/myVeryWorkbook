import 'package:flutter/material.dart';
import 'package:my_wordbook/pages/create_word.dart';
import 'package:my_wordbook/service/word_service.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:my_wordbook/widget/word_card.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Homepage");
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
                  child: Selector<WordbookService, String>(
                      selector: (context, service) => service.currentWordBookId,
                      builder: (context, service, child) {
                        return Text(
                          context
                              .read<WordbookService>()
                              .getCurrentWordBook()
                              .title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: DecoConst.secondColor,
                          ),
                        );
                      }),
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
            Consumer<WordbookService>(builder: (context, service, child) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ChangeNotifierProvider<Word>.value(
                      value: service.getCurrentWordBook().contents[index],
                      child: const WordCard(),
                    );
                  },
                  childCount: service.getCurrentWordBook().contents.length,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
