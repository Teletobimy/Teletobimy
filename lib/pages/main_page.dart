import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_1st_project/settings/page_setting.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentContentIndex = 0;
  List<String> _imageList = [
    'assets/slide-02.jpg',
    'assets/slide-03.jpg',
  ];

  List<Map<String, dynamic>> _contentList = [
    {
      'image': 'assets/slide-02.jpg',
      'text1': 'Men New-Season',
      'text2': 'JACKET & COATS'
    },
    {
      'image': 'assets/slide-03.jpg',
      'text1': 'Men Collection 2018',
      'text2': 'NEW ARRIVALS'
    },
    // 추가 이미지 및 텍스트들을 여기에 추가하세요.
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // 타이머가 더 이상 필요하지 않을 때 해제합니다.
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        // 이미지를 변경합니다.
        _currentContentIndex = (_currentContentIndex + 1) % _contentList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.24,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          _contentList[_currentContentIndex]['image']),
                      fit: BoxFit.fitWidth),
                ),
              ),
              Positioned(
                  top: 70,
                  left: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _contentList[_currentContentIndex]['text1'],
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        _contentList[_currentContentIndex]['text2'],
                        style: TextStyle(fontSize: 22),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          counter.setCount(1);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(113, 127, 224, 1.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            "SHOP NOW",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          Container(
            color: Colors.red,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Container(
            color: Colors.orange,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Container(
            color: Colors.brown,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ],
      ),
    );
  }
}
