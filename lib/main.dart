import 'package:flutter/material.dart';
import 'package:my_wordbook/pages/bookcase_page.dart';
import 'package:my_wordbook/pages/homepage.dart';
import 'package:my_wordbook/pages/mypage.dart';
import 'package:my_wordbook/service/wordbook_service.dart';
import 'package:my_wordbook/theme/deco_const.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WordbookService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IndexedStack(
            index: currentIndex,
            children: const [
              Homepage(),
              BookCasePage(),
              Mypage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: DecoConst.mainColor,
          unselectedItemColor: DecoConst.secondColor,
          onTap: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Icon(
                  Icons.cruelty_free,
                  size: 28,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Icon(
                  Icons.shelves,
                  size: 26,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 26,
                ),
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
