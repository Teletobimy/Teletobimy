import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String productId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productId = firestore.collection('products').doc().id;
  }

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  String _imageUrl = ''; // 이미지의 다운로드 URL

  Future<void> _uploadImage() async {
    // Firebase Storage에 이미지 업로드
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('product_images/$productId.jpg'); // productID를 파일명으로 사용

    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);

      // 업로드 후 이미지 다운로드 URL을 가져옵니다.
      TaskSnapshot uploadTask = await storageReference.putFile(imageFile);
      String imageUrl = await uploadTask.ref.getDownloadURL();

      // setState를 호출하여 다운로드된 이미지 URL을 갱신합니다.
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  Future<void> _addProductToFirestore() async {
    // Firebase Firestore 인스턴스 가져오기

    // 랜덤한 productID 생성

    // 'products' 컬렉션에 상품 추가
    await firestore.collection('products').doc(productId).set({
      'productId': productId,
      'categoty_id': CategoryChoice,
      'productName': _productNameController.text,
      'description': _descriptionController.text,
      'price': int.parse(_priceController.text),
      'stock': int.parse(_stockController.text),
      'sell_count': sell_count,
      'imageUrl': _imageUrl,
      'color_id': selectedColor,
      'size_id': selectedSize
    });

    // 상품 추가 후 필드 초기화
    _productNameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _stockController.clear();
    setState(() {
      _imageUrl = '';
    });
  }

  String CategoryChoice = '';
  String selectedColor = 'white';
  // String productId = "";

  // String generateRandomProductId(int length) {
  //   const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  //   final random = Random();
  //   return String.fromCharCodes(Iterable.generate(
  //       length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  // }

  void _showOptionsDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('선택지'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOptionButton(context, '아우터', 'outer'),
              _buildOptionButton(context, '상의', 'top'),
              _buildOptionButton(context, '하의', 'pants'),
            ],
          ),
        );
      },
    );

    // showDialog에서 반환된 값을 selectedOption에 저장
    if (result != null) {
      setState(() {
        CategoryChoice = result;
      });
    }
  }

  Widget _buildOptionButton(BuildContext context, String label, String value) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context, value); // 사용자가 선택한 값을 반환합니다.
      },
      child: Text(label),
    );
  }

  bool showDetail = false;
  int sell_count = 0;
  String selectedSize = "S";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton(
                onPressed: () async {
                  _uploadImage();
                },
                child: Text('Product Image')),
            ElevatedButton(
                onPressed: () {
                  _showOptionsDialog(context);
                },
                child: Text("Category")),
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextFormField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Stock'),
            ),
            DropdownButton<String>(
              value: selectedColor,
              onChanged: (value) {
                setState(() {
                  selectedColor = value!;
                });
              },
              items: <String>['white', 'black', 'green', 'red']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: selectedSize,
              onChanged: (value) {
                setState(() {
                  selectedSize = value!;
                });
              },
              items: <String>['S', 'M', 'L']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            if (showDetail)
              Column(
                children: [
                  Text("상품아이디 : $productId"),
                  Text("카테고리 : $CategoryChoice"),
                  Text("상품명 : ${_productNameController.text}"),
                  Text("상품설명 : ${_descriptionController.text}"),
                  Text('가격 : ${_priceController.text}'),
                  Text('재고 : ${_stockController.text}'),
                  Text('판매량 : $sell_count'),
                  Text('이미지 : $_imageUrl'),
                  Text("컬러 : $selectedColor"),
                  Text("사이즈 : $selectedSize"),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showDetail = true;
                });
              },
              child: Text('최종확인'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showDetail = false;
                });
              },
              child: Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                // 이미지 업로드 기능 호출
                _addProductToFirestore();
              },
              child: Text('품목등록'),
            ),
          ],
        ),
      ),
    );
  }
}
