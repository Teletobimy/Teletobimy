import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_1st_project/pages/add_product.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllProductData() async {
    // Firebase Firestore 인스턴스 가져오기
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 'users' 컬렉션의 모든 문서 가져오기
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('products').get();

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
              "상품관리 페이지",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductScreen()),
                  );
                  setState(() {});
                },
                child: Text("상품등록"))
          ],
        ),
        Expanded(
          child: FutureBuilder(
            future: getAllProductData(),
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
                      QueryDocumentSnapshot<Object?> productData =
                          snapshot.data!.docs[index];

                      // 사용자 정보 가져오기
                      String productId = productData['productId'];
                      String categoty_id = productData['categoty_id'];
                      String productName = productData['productName'];
                      int price = productData['price'];
                      int stock = productData['stock'];
                      int sell_count = productData['sell_count'];

                      return ListTile(
                        title: Text(productId),
                        subtitle: Text(categoty_id),
                        // 여기에 필요한 다른 사용자 정보 추가 가능
                        onTap: () {
                          // 각 사용자에 대한 상세 정보 페이지로 이동하거나 해당 정보 활용
                          // 예: Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen(userData: userData)));
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
