import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordController2 = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

//  final TextEditingController _genderController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _dobController = TextEditingController();

  Future<void> _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // 회원가입 성공 시, 추가 정보를 Firestore에 저장
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': _emailController.text,
        'name': _nameController.text,
        'gender': genderChoice[_selectedGender],
        'address': _addressController.text,
        'phoneNumber': _phoneNumberController.text,
        'dob': _dobController.text,
      });

      print('회원가입 및 정보 저장 성공: ${userCredential.user!.uid}');
      Navigator.pop(context);
    } catch (e) {
      print('회원가입 실패: $e');
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  List<String> genderChoice = <String>[
    '남자',
    '여자',
  ];
  int _selectedGender = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                controller: _emailController,
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
                controller: _passwordController,
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
                controller: _passwordController2,
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
                controller: _nameController,
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
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('성별 선택: '),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      // Display a CupertinoPicker with list of fruits.
                      onPressed: () => _showDialog(
                        CupertinoPicker(
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 28,
                          // This sets the initial item.
                          scrollController: FixedExtentScrollController(
                            initialItem: _selectedGender,
                          ),
                          // This is called when selected item is changed.
                          onSelectedItemChanged: (int selectedItem) {
                            setState(() {
                              _selectedGender = selectedItem;
                            });
                          },
                          children: List<Widget>.generate(genderChoice.length,
                              (int index) {
                            return Center(child: Text(genderChoice[index]));
                          }),
                        ),
                      ),
                      // This displays the selected fruit name.
                      child: Text(
                        genderChoice[_selectedGender],
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
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
                controller: _phoneNumberController,
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
                controller: _dobController,
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
                        onPressed: _register,
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
                      onPressed: _register,
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
