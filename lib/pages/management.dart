import 'package:flutter/material.dart';
import 'package:flutter_1st_project/pages/product_management.dart';
import 'package:flutter_1st_project/pages/user_management.dart';

class Management extends StatefulWidget {
  const Management({super.key});

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("관리자페이지"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("종료")),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: page[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 아이콘 4개 이상일 때 사용
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: '유저관리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits_rounded),
            label: '상품관리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.offline_pin_sharp),
            label: '오더관리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: '배송관리',
          ),
        ],
      ),
    );
  }

  final List<Widget> page = [
    // 각 페이지의 내용을 원하는 위젯으로 변경하세요
    UserManagement(),
    ProductManagement(),
    Container(
      color: Colors.orange,
      child: Center(
        child: Text('오더관리'),
      ),
    ),
    Container(
      color: Colors.red,
      child: Center(
        child: Text('배송관리'),
      ),
    ),
  ];
}
