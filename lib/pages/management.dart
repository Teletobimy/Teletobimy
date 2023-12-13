import 'package:flutter/material.dart';

class Management extends StatelessWidget {
  const Management({super.key});

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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              // 버튼 추가
              background: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {}, child: Text("유저관리")),
                  TextButton(onPressed: () {}, child: Text("상품관리")),
                  TextButton(onPressed: () {}, child: Text("오더관리")),
                  TextButton(onPressed: () {}, child: Text("배송관리")),
                  TextButton(onPressed: () {}, child: Text("결제관리")),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('회원가입'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(labelText: '이메일'),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: '비밀번호'),
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              // 다이얼로그를 닫습니다.
                              Navigator.of(context).pop();
                            },
                            child: Text('$index'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // 다이얼로그를 닫습니다.
                              Navigator.of(context).pop();
                            },
                            child: Text('수정'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // TODO: 회원가입 처리 로직을 추가하세요.
                              Navigator.of(context).pop(); // 다이얼로그를 닫습니다.
                            },
                            child: Text('종료'),
                          ),
                        ],
                      );
                    },
                  ),
                  title: Text('Item $index'),
                );
              },
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
