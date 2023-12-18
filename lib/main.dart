import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1st_project/pages/management.dart';
import 'package:flutter_1st_project/pages/register.dart';
import 'package:flutter_1st_project/settings/page_setting.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages/main_page.dart';
import 'pages/shopping_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Scaffold(
      drawer: Drawer(
          child: AppDrawer(
        scaffoldKey: _scaffoldKey,
      )),
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

class AppDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const AppDrawer({
    super.key,
    required this.scaffoldKey,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textEditingControllerEmail =
      TextEditingController();
  final TextEditingController _textEditingControllerPw =
      TextEditingController();
  late bool logined;
  String? displayName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_auth.currentUser != null) {
      print("동작");
      _logined();
      logined = true;
    } else {
      logined = false;
    }
  }

  Future<void> _logined() async {
    User? user = _auth.currentUser;
    print('$user');

    if (user != null) {
      try {
        // Firestore에서 사용자의 문서 가져오기
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        print(userDoc.toString());
        if (userDoc.exists) {
          print("이름 : ${userDoc['name']}");
          setState(() {
            displayName = userDoc['name'];
          });
          logined = true;
        } else {
          setState(() {
            displayName = '이름 없음';
            print("이름 : $displayName");
          });
        }
      } catch (e) {
        print('Firestore에서 사용자 이름 가져오기 오류: $e');
      }
    } else {
      logined = false;
    }
  }

  void _logout() async {
    await _auth.signOut();
    // 로그아웃 후 이동할 화면 설정 또는 다른 로직 추가 가능
    // 예: 로그인 화면으로 이동
    _auth.signOut();
    setState(() {
      logined = false;
    });
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _textEditingControllerEmail.text,
        password: _textEditingControllerPw.text,
      );
      // 로그인 성공 시, 추가 작업 수행
      // 예: 다음 화면으로 이동, 사용자 정보 표시 등
      print('로그인 성공: ${userCredential.user!.uid}');

      User? user = _auth.currentUser;

      if (user != null) {
        try {
          // Firestore에서 사용자의 문서 가져오기
          DocumentSnapshot userDoc =
              await _firestore.collection('users').doc(user.uid).get();

          if (userDoc.exists) {
            print("이름 : ${userDoc['name']}");
            setState(() {
              displayName = userDoc['name'];
            });
          } else {
            setState(() {
              displayName = '이름없음';
              print("이름 : $displayName");
            });
          }
        } catch (e) {
          print('Firestore에서 사용자 이름 가져오기 오류: $e');
        }
      } else {
        setState(() {
          displayName = null;
        });
      }

      setState(() {
        logined = true;
      });
    } catch (e) {
      print('로그인 실패: $e');
      // 로그인 실패 시, 사용자에게 알림을 표시하거나 다른 조치를 취할 수 있음
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
          !logined
              ? Column(
                  children: [
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
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue)),
                          onPressed: _login,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
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
                  ],
                )
              : Column(
                  children: [
                    Text(
                      '사용자 이름: ${displayName ?? "이름 없음"}',
                      style: TextStyle(fontSize: 18),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _auth.signOut();
                          setState(() {
                            logined = false;
                          });
                        },
                        child: Text("로그아웃"))
                  ],
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
}
