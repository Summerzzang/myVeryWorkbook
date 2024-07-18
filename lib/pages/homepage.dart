import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_wordbook/pages/create_word.dart';
import 'package:my_wordbook/service/word_service.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:my_wordbook/widget/progressbar.dart';
import 'package:my_wordbook/widget/word_card.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CarouselController _carouselController = CarouselController();

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
                    context.read<WordbookService>().currentWordBook.title,
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
            Selector<WordbookService, List<Word>>(
              selector: (context, service) => service.currentWordBook.contents,
              builder: (context, service, child) {
                if (service.isNotEmpty) {
                  return CarouselSlider.builder(
                    itemCount: service.length,
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      autoPlay: false,
                      aspectRatio: 1.15,
                      enlargeCenterPage: true,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return ChangeNotifierProvider<Word>.value(
                        value: service[index],
                        child: const WordCard(),
                      );
                    },
                  );
                } else {
                  //Todo 단어 없을 때 보이는 화면 추가하기
                  return const Text("No Word");
                }
              },
            ),
            const Progressbar(),
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateWordPage(),
                    //fullscreenDialog: true,
                  ),
                );
                _carouselController.jumpToPage(0);
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
