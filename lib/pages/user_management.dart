import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_1st_project/pages/user_details_screen.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUserData() async {
    // Firebase Firestore 인스턴스 가져오기
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 'users' 컬렉션의 모든 문서 가져오기
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('users').get();

    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey,
          width: double.infinity,
          height: 130,
          child: Center(
            child: Text(
              "유저관리 페이지",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: getAllUserData(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No data found'));
                } else {
                  // 가져온 사용자 정보를 리스트뷰로 표시
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Object?> userData =
                          snapshot.data!.docs[index];

                      // 사용자 정보 가져오기
                      String address = userData['address'];
                      String dob = userData['dob'];
                      String email = userData['email'];
                      String gender = userData['gender'];
                      String name = userData['name'];
                      String phoneNumber = userData['phoneNumber'];

                      return ListTile(
                        title: Text(name),
                        subtitle: Text(email),
                        // 여기에 필요한 다른 사용자 정보 추가 가능
                        onTap: () async {
                          // 각 사용자에 대한 상세 정보 페이지로 이동하거나 해당 정보 활용
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditUserDetailsScreen(
                                      userData: userData)));
                          setState(() {});
                        },
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
