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

  final List<Map<String, dynamic>> products = [
    {
      'name': '상품 1',
      'price': '10000원',
      'image': 'https://via.placeholder.com/150',
      'isFavorite': false,
    },
    {
      'name': '상품 2',
      'price': '20000원',
      'image': 'https://via.placeholder.com/150',
      'isFavorite': false,
    },
    {
      'name': '상품 3',
      'price': '20000원',
      'image': 'https://via.placeholder.com/150',
      'isFavorite': false,
    },
    {
      'name': '상품 4',
      'price': '20000원',
      'image': 'https://via.placeholder.com/150',
      'isFavorite': false,
    },
    {
      'name': '상품 5',
      'price': '20000원',
      'image': 'https://via.placeholder.com/150',
      'isFavorite': false,
    },
    {
      'name': '상품 6',
      'price': '20000원',
      'image': 'https://via.placeholder.com/150',
      'isFavorite': false,
    },
    {
      'name': '상품 7',
      'price': '20000원',
      'image': 'https://via.placeholder.com/150',
      'isFavorite': false,
    },
    {
      'name': '상품 8',
      'price': '20000원',
      'image': 'https://via.placeholder.com/150',
      'isFavorite': false,
    },
    {
      'name': '상품 9',
      'price': '20000원',
      'image': 'https://via.placeholder.com/150',
      'isFavorite': false,
    },
    // 다른 상품들 추가...
  ];

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Column(
      children: [
        Container(
          child: Stack(
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
        ),
        Container(
          height: 70,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BEST PRODUCTS",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "All Products",
                  style: TextStyle(
                      fontSize: 16, decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    // 이미지
                    Image.network(
                      products[index]['image'],
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    // 상품 이름
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                products[index]['name'],
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 4),
                              // 상품 가격
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: Text(
                                  products[index]['price'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              products[index]['isFavorite']
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              // 즐겨찾기 버튼 토글 동작
                              setState(() {
                                products[index]['isFavorite'] =
                                    !products[index]['isFavorite'];
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
