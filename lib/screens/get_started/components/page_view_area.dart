import 'package:flutter/material.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/screens/get_started/components/get_started_content.dart';
import 'package:my_muslim_app/screens/main/main_screen.dart';

class PageViewArea extends StatefulWidget {
  PageViewArea({Key? key}) : super(key: key);

  @override
  _PageViewAreaState createState() => _PageViewAreaState();
}

class _PageViewAreaState extends State<PageViewArea> {
  int currentPage = 0;

  List<Map<String, String>> getStartedData = [
    {
      "text": "Selamat datang di MUSLIM APP!",
      "image": "assets/images/started-1.png"
    },
    {
      "text":
          "Mulailah membangun kebiasaan\nuntuk senantiasa beribadah tepat waktu",
      "image": "assets/images/started-2.png"
    },
    {
      "text": "Dapatkan akses seluruh ayat Al-Qur'an\nhanya dari genggamanmu",
      "image": "assets/images/started-3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacer(
          flex: 1,
        ),
        Text(
          "BERSIAP MEMULAI",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          flex: 6,
          child: PageView.builder(
            itemCount: 3,
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            itemBuilder: (context, index) => GetStartedContent(
              text: getStartedData[index]["text"],
              image: getStartedData[index]["image"],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  getStartedData.length,
                  (index) => buildDot(index: index),
                ),
              ),
              Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, MainScreen.routeName);
                    },
                    child: Text(
                      'Memulai',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(PRIMARY_COLOR),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? PRIMARY_COLOR : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
