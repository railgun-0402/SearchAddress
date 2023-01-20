import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '郵便番号入力'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final postController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 郵便番号
    String postNum = '';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    child: Text(
                      '郵便番号',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    width: 90),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: InputDecoration(labelText: '郵便番号を入力'),
                    onChanged: (text) {
                      // textFieldの値を取得
                      postNum = postController.text;
                    },
                  ),
                ),
                OutlinedButton(
                  child: Text('検索'),
                  onPressed: () {
                    // 郵便番号で住所を検索するAPIを実行
                    searchAddress(postNum);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    child: Text(
                      '住所',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    width: 90),
                Expanded(
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // APIを実行して、住所を探す
  // またテキストに得られた住所を書き出す
  Future<void> searchAddress(String zipCode) async {
    // URL
    String url = 'https://zipcloud.ibsnet.co.jp/api/search?zipcode=';
    // 住所
    String address = '';

    // URLのクエリ文字に郵便番号を追記
    url = url + zipCode;
    // 実行
    var result = await get(Uri.parse(url));

    // json形式(key/value)なのでMapを使用
    Map<String, dynamic> data = jsonDecode(result.body);

    // それぞれの要素から住所を取得
    address = data['results'][0]['address1'];
    address += data['results'][0]['address2'];
    address += data['results'][0]['address3'];

    addressController.text = address;
  }
}
