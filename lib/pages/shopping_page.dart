import 'package:flutter/material.dart';

class ShoppingHomePage extends StatefulWidget {
  @override
  State<ShoppingHomePage> createState() => _ShoppingHomePageState();
}

class _ShoppingHomePageState extends State<ShoppingHomePage> {
  // 가상의 상품 목록 데이터
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
      'name': '상품 2',
      'price': '20000원',
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
      'name': '상품 2',
      'price': '20000원',
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
      'name': '상품 2',
      'price': '20000원',
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
      'name': '상품 2',
      'price': '20000원',
      'image': 'https://via.placeholder.com/150',
      'isFavorite': false,
    },
    // 다른 상품들 추가...
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavigationBar(
          surfaceTintColor: Colors.white,
          destinations: [
            TextButton(onPressed: () {}, child: Text("All Products")),
            TextButton(onPressed: () {}, child: Text("Outer")),
            TextButton(onPressed: () {}, child: Text("Top")),
            TextButton(onPressed: () {}, child: Text("Pants")),
          ],
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
