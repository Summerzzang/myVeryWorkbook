import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_wordbook/pages/create_word.dart';
import 'package:my_wordbook/service/word_service.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:my_wordbook/widget/progressbar.dart';
import 'package:my_wordbook/widget/word_card.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Homepage");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: DecoConst.lightGreyColor,
              ),
              child: Selector<WordbookService, String>(
                selector: (context, service) => service.currentWordBookId,
                builder: (context, service, child) {
                  return Text(
                    context.read<WordbookService>().getCurrentWordBook().title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: DecoConst.secondColor,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
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
            ),
            Consumer<WordbookService>(
              builder: (context, service, child) {
                return CarouselSlider.builder(
                  itemCount: service.getCurrentWordBook().contents.length,
                  options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 1.15,
                    enlargeCenterPage: true,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return ChangeNotifierProvider<Word>.value(
                      value: service.getCurrentWordBook().contents[index],
                      child: const WordCard(),
                    );
                  },
                );
              },
            ),
            const Progressbar(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateWordPage(),
                    //fullscreenDialog: true,
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: DecoConst.lightGreyColor,
                ),
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
