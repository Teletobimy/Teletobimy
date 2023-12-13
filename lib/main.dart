import 'package:flutter/material.dart';
import 'package:flutter_1st_project/pages/management.dart';
import 'package:flutter_1st_project/pages/register.dart';
import 'package:flutter_1st_project/settings/page_setting.dart';
import 'package:provider/provider.dart';

import 'pages/main_page.dart';
import 'pages/shopping_page.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Counter(),
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.pink,
            useMaterial3: true,
          ),
          home: MainApp(),
        ));
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _textEditingControllerEmail =
      TextEditingController();
  final TextEditingController _textEditingControllerPw =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(
            textEditingControllerEmail: _textEditingControllerEmail,
            textEditingControllerPw: _textEditingControllerPw),
      ),
      appBar: AppBar(
        title: Text('COZA STORE'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          FavoriteButton(),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: _pages[counter.count],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 아이콘 4개 이상일 때 사용
        currentIndex: counter.count,
        onTap: (index) {
          setState(() {
            counter.setCount(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  final List<Widget> _pages = [
    // 각 페이지의 내용을 원하는 위젯으로 변경하세요
    MainPage(),
    ShoppingHomePage(),
    Container(
      color: Colors.orange,
      child: Center(
        child: Text('세 번째 페이지'),
      ),
    ),
    Container(
      color: Colors.red,
      child: Center(
        child: Text('네 번째 페이지'),
      ),
    ),
  ];
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          RightModalSheet(context);
        },
        icon: Icon(Icons.favorite_border_rounded));
  }

  Future<Null> RightModalSheet(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Center(
                child: Text('WISH'),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required TextEditingController textEditingControllerEmail,
    required TextEditingController textEditingControllerPw,
  })  : _textEditingControllerEmail = textEditingControllerEmail,
        _textEditingControllerPw = textEditingControllerPw;

  final TextEditingController _textEditingControllerEmail;
  final TextEditingController _textEditingControllerPw;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'COZA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "STORE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  TextField(
                    controller: _textEditingControllerEmail,
                    decoration: InputDecoration(
                        helperText: "이메일",
                        helperStyle: TextStyle(color: Colors.white)),
                  ),
                  TextField(
                    controller: _textEditingControllerPw,
                    decoration: InputDecoration(
                        helperText: "비밀번호",
                        helperStyle: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          // 다른 로그인 옵션들을 추가할 수 있습니다.
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                onPressed: () {},
                child: Text(
                  "로그인",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Row(
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showCalendarsModalBottom(context);
                  },
                  child: Text(
                    'Sign up!',
                    style: TextStyle(
                        color: Colors.blue[300],
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                )
              ],
            ),
          ),
          ListTile(
              title: Text(
            "Notice",
            style: TextStyle(fontSize: 19),
          )),
          ListTile(
              title: Text(
            "FAQs",
            style: TextStyle(fontSize: 19),
          )),
          ListTile(
              title: Text(
            "Q & A",
            style: TextStyle(fontSize: 19),
          )),
          ListTile(
            title: Text("관리자모드"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Management(),
                  ));
            },
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8, 70, 8, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/bottom.jpg"))),
            ),
          )
        ],
      ),
    );
  }

  Future<Null> showCalendarsModalBottom(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  '회원가입',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '이메일',
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // 내용과 테두리 간의 간격 조절
                  isDense: true,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  icon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // 내용과 테두리 간의 간격 조절
                  isDense: true,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호확인',
                  icon: Icon(Icons.lock_open_outlined),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // 내용과 테두리 간의 간격 조절
                  isDense: true,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '이름',
                  icon: Icon(Icons.text_fields_sharp),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // 내용과 테두리 간의 간격 조절
                  isDense: true,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: '성별',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // 내용과 테두리 간의 간격 조절
                  isDense: true,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '주소',
                  icon: Icon(Icons.house_rounded),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // 내용과 테두리 간의 간격 조절
                  isDense: true,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '휴대폰번호',
                  icon: Icon(Icons.phone_android_rounded),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // 내용과 테두리 간의 간격 조절
                  isDense: true,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '생년월일',
                  icon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // 내용과 테두리 간의 간격 조절
                  isDense: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 14, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black87)),
                        onPressed: () {},
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black87)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "돌아가기",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
