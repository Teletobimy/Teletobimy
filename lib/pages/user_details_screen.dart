import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserDetailsScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> userData;

  const EditUserDetailsScreen({Key? key, required this.userData})
      : super(key: key);

  @override
  _EditUserDetailsScreenState createState() => _EditUserDetailsScreenState();
}

class _EditUserDetailsScreenState extends State<EditUserDetailsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    // 사용자 정보를 불러와 각 컨트롤러에 초기값으로 설정합니다.
    _nameController = TextEditingController(text: widget.userData['name']);
    _emailController = TextEditingController(text: widget.userData['email']);
    // 필요에 따라 다른 컨트롤러도 초기값 설정 가능
  }

  @override
  void dispose() {
    // 사용이 끝난 컨트롤러는 해제해주어야 합니다.
    _nameController.dispose();
    _emailController.dispose();
    // 필요에 따라 다른 컨트롤러도 해제 가능
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사용자 정보 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '이메일'),
            ),
            // 필요에 따라 다른 TextFormField도 추가 가능
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 수정된 정보를 저장하고 Firestore에 업데이트하는 로직을 구현할 수 있습니다.
                updateUserData();
              },
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUserData() async {
    // Firestore에 사용자 정보를 업데이트하는 로직을 작성합니다.
    // 수정된 정보를 컨트롤러에서 가져와서 Firestore에 업데이트할 수 있습니다.
    String newName = _nameController.text;
    String newEmail = _emailController.text;

    // Firestore에 수정된 정보 업데이트
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userData.id)
        .update({
      'name': newName,
      'email': newEmail,
      // 필요에 따라 다른 필드도 업데이트 가능
    });

    // 업데이트 후 이전 페이지(사용자 목록 페이지)로 돌아가기
    Navigator.pop(context);
  }
}
